# File Proxy

A toy project to see if I can make a library with no knowledge of an external
storage service read files from and write files to that service.

Why would you want to do this? Well, here's an example of reading a CSV:

    require 'csv'
    CSV.foreach("./employees.csv",
      :headers => :first_row) do |row|
      puts row.to_hash.inspect
    end

This causes the CSV library to read the file `employees.csv` from the local
filesystem. What if I have access to that file from a central resource, maybe
an HR database, and it's exposed over something like HTTP? Do I really want to
deal with downloading that file before I read it? Why can't I just tell `CSV`
where the file lives?

    CSV.foreach("http://hr.local/data/employees.csv",
      :headers => :first_row) do |row|
      puts row.to_hash.inspect
    end

I could pass an `IO` to the `CSV` library which correctly wrapped the HTTP
resource, and that would be perfectly valid and in this case arguable better,
but there are plenty of other libraries that don't provide the same degree of
flexibility and I want to see if I can support those too. I'd also like to not
worry about providing IO wrappers around common things like reading from or
writing to objects stored in s3 or on some FTP server.


## A word of warning

This is a toy project and I'm not sure I'd use it for anything serious unless
there was absolutely no better way. "Better" is, of course, rather subjective,
so I'll leave that up to you do decide.

Here are some alternatives that were suggested to me as more sane solutions
when talking about this project:

  * Use `open-uri` to read files
  * Mount the remote service via FUSE

I'm sure there are others - feel free to add your suggestions here.


## How is it used and how does it work?

Include the shim into the `File` class:

    require 'file_proxy'
    File.class_eval { include FileProxy::Shim }

That little piece of code totally screws with the `File` class as provided by
stdlib. I'd encourage you to read the code to find out exactly the sort of
crazy things I'm doing.

From now on, any file access (via `File` at least) will try to parse the path
as an `URI`. If there's no scheme part to the URI, as will be the case with
normal filesystem paths, then proxy back to the original `File` class ie
behaviour should not be changed.

If there *is* a scheme in the URI then attempt to load the appropriate Proxy
behaviour from `FileProxy::Proxies::<Scheme>Proxy` and call the method which
was origianlly called on `File` from that, passing the same arguments
(including blocks, if any) to that method.


## Who made this crazy thing?

[Craig R Webster][0] wrote most of the madness.

Jon Wood helped work out how to delegate back to the original File class.

Tom Stuart and James Adam tried to talk me into doing something sane (sorry
guys) and talked about how to capture the original File class before futzing
with it.

[0]: mailto:craig@barkingiguana.com


## Licence

Since nothing is complete without a licence, this is released under the terms
of the MIT licence, a copy of which is included in the LICENCE file.

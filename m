Date: Wed, 22 Aug 2001 15:41:48 -0700
Subject: Re: assorted kernel patches
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v453)
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
From: "David A. Gatwood" <dgatwood@apple.com>
In-Reply-To: <200108222112.f7MLCTt439203@saturn.cs.uml.edu>
Message-Id: <DF5A59D0-974E-11D5-9C89-003065B90BBC@apple.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday, August 22, 2001, at 02:12 PM, Albert D. Cahalan wrote:

>
> Paul Mackerras writes:
>> Edward Swarthout writes:
>
>>> 1. Support for hardware breakpoints for process threads.
>>
>> A good idea in general although I will be interested to see
>> how this interacts with xmon's and kgdb's use of iabr/dabr.
>
> Who cares? Take a look at the Alpha and i386 Linux ports.
> Debugger support for users is important. Kernel hackers can
> live without it. (including myself)

Depends on what part of the kernel.  Sure, you can debug a driver with
printf debugging, generally.  But as anybody who ever tried to debug a
file system without a kernel debugger will testify, it ain't pretty.
Threw gdb at it, and suddenly problems that had been thwarting detection
for weeks suddenly became blindingly obvious....

This particularly becomes a problem when the debugging information you
need would require dumping a screen worth of data for every block
written to or read from the disk and occurs only after a few gigabytes
of data are written or read.  If you have ever stared blankly at tens or
even hundreds of thousands of lines of debug output from a single test
run to figure out what went wrong, only then will you understand why no
sane person would say that kernel debuggers are unnecessary.  Been
there, done that.  Never, ever, ever, never, ever again.  :-)


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

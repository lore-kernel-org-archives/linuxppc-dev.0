Date: Sat, 22 May 1999 23:11:50 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Samuel Rydh <samuel@ibrium.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mac-on-Linux
In-Reply-To: <19990522193719.15424@ibrium.se>
Message-ID: <Pine.LNX.3.96.990522230946.28685E-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 22 May 1999, Samuel Rydh wrote:

> The Mac-on-Linux kernel support code has in principle the following 
> tasks:
> 
>   - Emulate privileged instructions.
>   - Handle the MMU (maps ROM, RAM etc.)
> 
> The implementation is primarily based upon hooks in the
> low-level exception handlers. Besides this, the interaction
> with the kernel has been kept at a minimum.
> 
> I believe the exception hooks must be put into the
> mach kernel - possibly it is easiest to put all code 
> there.

There would be advantages and disadvantages.  Speed-wise, it'd be great if
it were all in mach and if the mac-on-linux binary were mach aware,
detecting Mach's presense, and using direct calls into Mach. 
Simplicity-wise, we could stick an abstraction layer in there in the linux
server so that it mostly looked the same to mac-on-linux whether it was
running on LinuxPPC or MkLinux.  Not sure which would end up being the
most advantageous, but it's probably a moot point until the Mach handling
changes are made.  :-)


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Sun, 16 May 1999 20:50:26 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Wolfgang Denk <wd@denx.de>
cc: linuxppc-dev@lists.linuxppc.org, dev@kernel.crashing.org
Subject: Re: LinuxPPC-DR-1.0: X11 config for Powerbook G3 series?
In-Reply-To: <199905162253.AAA00308@denx.muc.de>
Message-ID: <Pine.LNX.4.05.9905162049010.651-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 17 May 1999, Wolfgang Denk wrote:

> 	(--) FBDev: Mode "1024x768" needs hsync freq of 93.99 kHz. Deleted.
                                                        ^^^^^
> 	(**) FontPath set to "unix/:-1"
> 	(**) FBDev: Using XF86Config video mode database
...
> [root@luke X11]# cat XF86Config
...
> # HorizSync is in kHz unless units are specified.
> # HorizSync may be a comma separated list of discrete values, or a
> # comma separated list of ranges of values.
> # NOTE: THE VALUES HERE ARE EXAMPLES ONLY.  REFER TO YOUR MONITOR'S
> # USER MANUAL FOR THE CORRECT NUMBERS.
> 
>     HorizSync   119

Change that.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

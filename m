Date: Fri, 18 Jun 1999 14:28:33 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Ben McKenzie <ben@comp.uark.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: mvme 4600 (fwd)
In-Reply-To: <Pine.SOL.4.10.9906171510080.21875-100000@comp>
Message-ID: <Pine.LNX.3.96.990618142524.19995A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 17 Jun 1999, Ben McKenzie wrote:

> Has anyone had any luck getting an MVME 4600 machine to boot?
> I found a distribution called PowerPLusLinux that supposedly supports
> MVME boards, but I also noticed that there is specific code in the
> kernel source for MVME boards.

Sure.  Check the archives, Johnnie Peters just posted a patch containing
code to park the 2nd CPU on the 4600 until the SMP code is more stable.
Other than that, 2.2.10 official or vger have what you need.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Sandpoint X3 with MPC755
Date: Thu, 23 Jan 2003 18:21:09 -0600
Message-ID: <CD5CA14300A9D54A8D13D58CD3C87B4256E8F6@advcorp-exc01.advent.com>
From: "Dan Douglass" <ddouglass@adventnetworks.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark,

Thanks, I do not have the kernel source from the development tree. I will download it. However, it appears that the Sandpoint boards supported in U-Boot are for the 8240 and the 8245. I guess that is where my work will begin.

Thanks again,
Dan

-----Original Message-----
From: Mark A. Greer [mailto:mgreer@mvista.com]
Sent: Thursday, January 23, 2003 6:17 PM
To: Dan Douglass
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint X3 with MPC755


Dan Douglass wrote:

>Mark,
>
>Can you give me some insight as to where it is located then? I do not see support for it in U-Boot nor the kernel version I mentioned (2.4.21).
>
>
Dan,

You must not be looking in the right place (for kernel support).
Sandpoint X3 support is in the linuxppc_2_4_devel tree.  You can clone
the bk repository at bk://ppc.bkbits.net/linuxppc_2_4_devel.

As far as U-Boot, I don't use it but I thought it ran on the sandpoint
(at least, I think PPCBoot used to).  DINK comes on the sandpoint & the
zImage.sandpoint produced when you build the kernel (make zImage) will
run on recent versions of that firmware.

If you need more help getting the source, try looking at
http://penguinppc.org/dev/kernel.shtml  Note that there are currently a
few problems with IDE in that tree right now.

If you're looking for a truly supported version, go to
http://www.mvista.com and/or [I believe] http://www.denx.de.  There are
probably others as well.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3E3085EF.8060203@mvista.com>
Date: Thu, 23 Jan 2003 17:16:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Dan Douglass <ddouglass@adventnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint X3 with MPC755
References: <CD5CA14300A9D54A8D13D58CD3C87B4256E8F5@advcorp-exc01.advent.com>
In-Reply-To: <CD5CA14300A9D54A8D13D58CD3C87B4256E8F5@advcorp-exc01.advent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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

Date: Mon, 26 Aug 2002 13:57:47 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Downloading Image
Message-ID: <20020826135747.A10250@home.com>
References: <000f01c24d3e$4fed5460$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000f01c24d3e$4fed5460$370da8c0@aman>; from aman@mistralsoftware.com on Tue, Aug 27, 2002 at 01:52:34AM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 27, 2002 at 01:52:34AM +0530, Aman wrote:
>
> Hi
>
> I have build a linux image for IBM PPC 440 using the
> src-linuxppc_2_4_devel.tar.bz2 [Powerpc Kernel Source] taken from the
> website http://www.ppckernel.org/tree.php?id=5. Now I want to download the
> image to the IBM PPC 440 evalkit for which I used elf2ppceval utilility by
> Grant Erickson.  I copied the script and named as mkevimg.shar. When I
> executed the command  "unshar mkevimg.shar ". I got the following error

This step is unnecessary.  The kernel build process generates a
'zImage.ebony' which is directly bootable on the IBM 440GP reference
board.

> Can anyone help me in solving this issue or please suggest the way of
> downloading a the 440 image to the IBM PPC 440 evalkit. Also can you suggest
> me the cross-compiler for PPC 440.

The ppc4xx toolchain from the free ELDK is what you are looking for.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <003001c255c7$a246ff90$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "Matt Porter" <porter@cox.net>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <000f01c24d3e$4fed5460$370da8c0@aman> <20020826135747.A10250@home.com>
Subject: ELDK Compiler
Date: Fri, 6 Sep 2002 22:35:42 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Matt

I  have downloaded ELDK compiler for PPC 440 evalkit. In the ELDK html file
, it says the the predefined compiler flag as "mcpu=403". Will this ELDK
compiler work very well with PPC 440 processor?. Or are there any other
compilers which works well with PPC 440 processor.

Thanking you in advance

Regards
Aman


----- Original Message -----
From: "Matt Porter" <porter@cox.net>
To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, August 27, 2002 2:27 AM
Subject: Re: Downloading Image


>
> On Tue, Aug 27, 2002 at 01:52:34AM +0530, Aman wrote:
> >
> > Hi
> >
> > I have build a linux image for IBM PPC 440 using the
> > src-linuxppc_2_4_devel.tar.bz2 [Powerpc Kernel Source] taken from the
> > website http://www.ppckernel.org/tree.php?id=5. Now I want to download
the
> > image to the IBM PPC 440 evalkit for which I used elf2ppceval utilility
by
> > Grant Erickson.  I copied the script and named as mkevimg.shar. When I
> > executed the command  "unshar mkevimg.shar ". I got the following error
>
> This step is unnecessary.  The kernel build process generates a
> 'zImage.ebony' which is directly bootable on the IBM 440GP reference
> board.
>
> > Can anyone help me in solving this issue or please suggest the way of
> > downloading a the 440 image to the IBM PPC 440 evalkit. Also can you
suggest
> > me the cross-compiler for PPC 440.
>
> The ppc4xx toolchain from the free ELDK is what you are looking for.
>
> Regards,
> --
> Matt Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can hear Windows reboot.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

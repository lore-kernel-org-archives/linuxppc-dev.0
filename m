Message-ID: <3A072049.C2096C5C@mvista.com>
Date: Mon, 06 Nov 2000 13:19:06 -0800
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: John Jones <john@iigi.net>
CC: LinuxPPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How do I get the c++ compiler
References: <3A02ECF3.1E072842@iigi.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,
The .ppc.rpm packages are built to run on a Yellow Dog host.
MontaVista has not made the compilers/assembler/linker
available to run on the target hardware. The reason for this
is the requirement for temporary files and space considerations.

Cal

John Jones wrote:

> How do I get the c++ compiler on the nfs drive?  I have an Embedded
> Planet clcc.
>
> I try to install the: hhl-ppc_8xx-c++-2.95.2-13.ppc.rpm by running the
> command
>
> rpm -ihv hhl-ppc_8xx-c++-2.95.2-13.ppc.rpm (from my i386 host machine)
> and Iget the error: package hhl-ppc_8xx-c++-2.95.2-13 is for a different
> architecture.
>
> I have already installed the i386 version, but I think that is just for
> my i386 host, right?
>
> Am I supposed to install the ppc.rpm FROM the target machine?  It does
> not seem to
> have the rpm program to do so.
>
> HELP.
>
> Thanks.
>
> -John
>
> --
> <Help further Linux by signing the Linux Driver Petition:
> http://www.libranet.com/petition.html>
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Customer Support Engineer    490 Potrero Avenue
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
web http://www.mvista.com    support e-mail: support@mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

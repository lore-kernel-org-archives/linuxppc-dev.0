Message-ID: <39B51634.2AC1C034@mvista.com>
Date: Tue, 05 Sep 2000 08:50:12 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: HARDHAT 1.2 -> libc_nonshared.a not found by LD!
References: <004301c01712$24e03ee0$0a00010a@paoloweb>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo,
You could add -L /opt/hardhat/devkit/8xx/powerpc-hardhat-linux/lib
to you build file. That would force the linker to look there.
Cal

Paolo Scaffardi wrote:

> I installed HardHat 1.2 on my i386 Linux box to cross-compiling for my
> mpc823 fads board on the previous working hardhat version (Journeyman). I
> had many projects and packages configured to cross-compile. I tried to
> rebuild them with the new toolkit but i experienced one big problem that i
> cannot resolve by myself.
>
> While trying to configure and compile GGI, i got this error from the linker
> (/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux/bin/ld):
>
> cannot find /lib/libc_nonshared.a
>
> It seems that the linker looks for it in the host /lib instead of target
> /lib (under /opt/hardhat/devkit/8xx/powerpc-hardhat-linux/lib).
>
> How can resolve this?
>
> I spent one day to indagate on this... :-((
>
> Bye,
> Paolo
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

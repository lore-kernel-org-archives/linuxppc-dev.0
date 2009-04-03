Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f205.google.com (mail-gx0-f205.google.com
	[209.85.217.205]) by ozlabs.org (Postfix) with ESMTP id B2A0FDDEE2
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 07:36:15 +1100 (EST)
Received: by gxk1 with SMTP id 1so3852568gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Apr 2009 13:36:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000701c99cef$c27da220$3e0414ac@esisar.inpg.fr>
References: <Acmc78JUf+jQdi0gRC2eOyyoTEuRNw==>
	<000701c99cef$c27da220$3e0414ac@esisar.inpg.fr>
Date: Fri, 3 Apr 2009 14:35:56 -0600
Message-ID: <fa686aa40904031335y275eadf5kc0720ccc4d65590b@mail.gmail.com>
Subject: Re: GDB problem with Xilinx GIT Linux on Virtex5FX PPC440
From: Grant Likely <grant.likely@secretlab.ca>
To: Frederic LEGER <frederic.leger@esisar.grenoble-inp.fr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I unfortunately don't have an answer for you, but I have had problems
in the past with GDB on virtex ppc405.  I don't know if it is related.
 I'll try to dig up my old notes, but no promises.

g.

On Wed, Mar 4, 2009 at 11:36 AM, Frederic LEGER
<frederic.leger@esisar.grenoble-inp.fr> wrote:
> Hi,
>
> At the moment I can't set any breakpoint under gdb or gdbserver on ML510 and
> AVNETV5FX30T, if I set one => die "continuing...".
>
> Everything else is OK for a while on both boards: cross-compiling, dhcp,
> netperf, custom apps, .... but not debugging !
>
> If you have a working gdb (and/or gdbserver) on PPC440 Linux , could you
> please anwer this message with the following piece of information:
>
> Board
> kernel revision
> kernel snapshot (day/number) used from Xilinx GIT
> defconfig used
> toolchain (ELDK/buildroot...)
> toolchain version
> location of the rootfs (ramdisk, SysACE partition, flash Uboot partition)
> Type of the rootfs
>
> Thank you very much in advance.
>
> Best regards,
>
> Frederic
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <wd@denx.de>
To: "VenkataKrishna" <venkatakrishnap@vrindatech.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: linux compiling in ELDK
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20081004112414.525C8DDD0C@ozlabs.org>
References: <20081004112414.525C8DDD0C@ozlabs.org>
Date: Sat, 04 Oct 2008 16:26:07 +0200
Sender: wd@denx.de
Message-Id: <20081004142607.C55032478C@gemini.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear "VenkataKrishna",

In message <20081004112414.525C8DDD0C@ozlabs.org> you wrote:
> 
>     The tooks arch/ppc/configs/TQM8260_defconfig files and change to

arch/ppc is dead and gone - it has been removed from recent  versions
of  the Linux kernel tree. The TQM8260 has never been actually ported
to (and never been supported in) the 2.6 Linux context.

> VTPLM8260_defconfig in that I changed CONFIG_TQMM8260=y to
> CONFIG_VTPLM8260=y.

I canot find any trace of a board named VTPLM8260 in the kernel.org
Linux tree (nor in our linux-2.6-dex repo).

>    I got error shown below how I can solve this problem. But I used
> TQM8260_defconfig file that time working fine. 

Obviously you are working with your own, out-of-tree port of Linux.
And obviously your port is incomplete / buggy.

We don't know what you changed, or what your hardware looks like,  or
why you think that the (unsupported) TQM8260 board would be useful as
a reference.

There is little we can do based on such little information.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A list is only as strong as its weakest link.            -- Don Knuth

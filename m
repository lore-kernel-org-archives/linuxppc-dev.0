Return-Path: <wd@denx.de>
To: bourkeb idir <bourkeb.idir@yahoo.fr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: linux tqm8260
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1309510675.9518.YahooMailNeo@web29503.mail.ird.yahoo.com>
References: <1309510675.9518.YahooMailNeo@web29503.mail.ird.yahoo.com>
Date: Sun, 03 Jul 2011 21:01:03 +0200
Message-Id: <20110703190103.ADE301222337@gemini.denx.de>
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear bourkeb idir,

In message <1309510675.9518.YahooMailNeo@web29503.mail.ird.yahoo.com> you wrote:

> i'm trying to port linux in a tqm8260 fresscale card with an mpc8260
> cpu .i've already ported u-boot and it seems working but now i'm
> trying to cross compile a linux kernel 2.4.4 (which have a config
> file for tqm8260) and i always get trouble when i try to make a
> zImage . can anyone help me ,please?

This statement makes little sense to me.

First, the TQM8260 is not a Freescare card.  The manufacturer is (or
rather was) TQ Systems.

Second, I wonder why you would spend any efforts into such a system -
the product was EOLed a long time ago.

Third, when the product was still alive, it was pretty well supported
by U-Boot and Linux.  U-Boot sopport for it is still available in
mainline.  Linux support was available in our linuxppc_2_4_devel tree
up to and including Linux version 2.4.25.  So using 2.4.4 as a
starting point for such a work is even more incomprehensible to me.


If you really have a TQM8260 board, then just use the mainline U-Boot
code (current release, i. e. v20100.06) and the old 2.4.25 based
source tree mentioned above.

But be warned: this is ancient hardware, and so is the kernel code.
There is no guarantee it will even compile using recent tool chains.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You've no idea of what a poor opinion  I  have  of  myself,  and  how
little I deserve it.                                  - W. S. Gilbert

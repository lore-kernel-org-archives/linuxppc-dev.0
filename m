Return-Path: <maz@misterjones.org>
Received: from young-lust.wild-wind.fr.eu.org (lopsy-lu.misterjones.org
	[62.4.18.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2173C685ED
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 04:16:07 +1000 (EST)
From: Marc Zyngier <maz@misterjones.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <wrpll0of535.fsf@wild-wind.fr.eu.org>
	<1129869509.6265.32.camel@gaston>
Date: Fri, 21 Oct 2005 20:08:55 +0200
Message-ID: <wrpek6eeo94.fsf@wild-wind.fr.eu.org>
In-Reply-To: <1129869509.6265.32.camel@gaston> (Benjamin Herrenschmidt's
	message of "Fri, 21 Oct 2005 14:38:29 +1000")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: Re: v2.6.13.4 : Bad page state at prep_new_page when booting with
	quik
Reply-To: maz@misterjones.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "BenH" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

BenH> I'd suggest dumping to 8 or so first words of sysctrl_regs and checking
BenH> what difference is there.

Here you go :

BootX :

*fde69000 = 10000000
*fde69004 = 00000000
*fde69008 = 04000000
*fde6900c = 00000000
*fde69010 = 04101102
*fde69014 = 00000000
*fde69018 = 00000345
*fde6901c = 00000000

Quik:

*fdeff000 = 10000000
*fdeff004 = 00000000
*fdeff008 = 04000000
*fdeff00c = 00000000
*fdeff010 = 04101102
*fdeff014 = 00000000
*fdeff018 = 00000345
*fdeff01c = 00000000

Except for the ioremap address being different, not much to see
here...

BenH> It could be something else tho ... like some problem with
BenH> quik...

I fear that... But even in such a case ,understanding what confuses
the kernel would help a lot...

Thanks for your help,

	M.
-- 
And if you don't know where you're going, any road will take you there...

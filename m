Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com [75.148.32.185])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 282AE2C00ED
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Aug 2013 03:17:53 +1000 (EST)
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: MPC8315 reboot failure, lockdep splat possibly related?
From: Anthony Foiani <tkil@scrye.com>
References: <g61v5p02b.fsf@dworkin.scrye.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07114F7C@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Sat, 17 Aug 2013 11:17:49 -0600
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07114F7C@039-SN2MPN1-013.039d.mgd.msft.net>
 (Bhushan Bharat-R's message of "Sat\, 17 Aug 2013 04\:58\:34 +0000")
Message-ID: <g1u5sp77m.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bharat, greetings --

Bhushan Bharat-R65777 <R65777@freescale.com> writes:

> You should get rid of this by changing spin_lock/unlock() in
> fsl_sata_set_irq_coalescing() to spin_lock_irqsave/restore()

I'll do that -- thanks!

Looks like linux-next still has plain spin_lock, not the irqsave variant.

Is this something that needs to be pushed to mainline and/or stable?

If it should go upstream, is this something that Freescale can do, or
should I try to put together a patch?  (I'd like to avoid having to do
it myself, because I'm carrying out-of-tree patches that I'd have to
port to linux-next before it'd be accepted there, I fear.)

Either way, I'll definitely report if it fixes the splat on my 3.9.7
system.

Thanks again!

Best regards,
Anthony Foiani

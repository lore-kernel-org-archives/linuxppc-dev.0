Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id EC5BCDE71C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 05:26:59 +1000 (EST)
Date: Thu, 17 Apr 2008 23:26:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/5] Few more patches for Kumar's powerpc.git
Message-ID: <20080417192656.GA19107@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Kumar,

Here is respin of my pending patches.

I have bunch of others, but they depend on the drivers which I'm
going to send for the merge after OF GPIO will hit Linus' tree
(otherwise respective subsystem maintainers will fail even to
compile-test these drivers). Given that, in worst case, I'm afraid
I'll have to try to break merge window rules, or keep the patches for
the next one.

Though, I hope tomorrow I'll send patch that adds new driver's (MCU,
GPIO LEDs, USB FHCI, UPM NAND) bindings to the booting-without-of.txt,
so subsystem maintainers won't have to bother with PowerPC bits.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

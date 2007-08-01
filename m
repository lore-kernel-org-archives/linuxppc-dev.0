Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B966DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 19:14:48 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1IG9Nc-000513-4j
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Aug 2007 10:16:28 +0200
Date: Wed, 1 Aug 2007 10:16:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.23-rc1-mm2
Message-ID: <20070801081600.GA30482@elte.hu>
References: <20070731230932.a9459617.akpm@linux-foundation.org>
	<200708011002.30962.m.kozlowski@tuxland.pl>
	<20070801011323.6e8d8259.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070801011323.6e8d8259.akpm@linux-foundation.org>
Cc: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 1 Aug 2007 10:02:30 +0200 Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:
> 
> > Hello,
> > 
> > 	I get this warning. Looking at the comment in kernel/irq/resend.c
> > it's harmless. Is it?

yeah, harmless.

	Ingo

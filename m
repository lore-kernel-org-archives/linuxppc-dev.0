Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3.cisco.com [171.71.176.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-3.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 31741DE638
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 04:17:10 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211906268.3435.44.camel@localhost.localdomain>
	<adad4n71wb3.fsf@cisco.com>
	<1211910825.7160.1.camel@localhost.localdomain>
	<adamymbvcxi.fsf@cisco.com>
Date: Tue, 27 May 2008 11:17:04 -0700
In-Reply-To: <adamymbvcxi.fsf@cisco.com> (Roland Dreier's message of "Tue, 27
	May 2008 11:07:05 -0700")
Message-ID: <adaej7nvcgv.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, torvalds@linux-foundation.org,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Writes are posted yes, but not reordered arbitrarily.

on standard x86 I mean here...

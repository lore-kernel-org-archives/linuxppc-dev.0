Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 66EFFDDE32
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 02:19:43 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Gdbserver syscall clobber
References: <469B922D.3050701@billgatliff.com>
	<20070716155348.GA5281@caradoc.them.org>
	<469E550E.5080905@billgatliff.com>
	<20070718183143.GA25324@caradoc.them.org>
	<46A4D1F5.1060005@billgatliff.com>
Date: Mon, 23 Jul 2007 18:19:37 +0200
In-Reply-To: <46A4D1F5.1060005@billgatliff.com> (Bill Gatliff's message of
	"Mon\, 23 Jul 2007 11\:06\:13 -0500")
Message-ID: <jemyxn6qjq.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bill Gatliff <bgat@billgatliff.com> writes:

> Daniel Jacobowitz wrote:
>> On Wed, Jul 18, 2007 at 12:59:42PM -0500, Bill Gatliff wrote:
>>   
>>> Now, I'm a little rusty on PPC asm (I've been doing a lot of ARM
>>> lately), but it looks to me like the kernel is setting bit 0 in CR0
>>> (oris r10, r10, 0x1000) a.k.a LT, but the user side is looking at CR0
>>> (bnslr+) bit 3 a.k.a. SO.

Bits are numbered from left to right, thus 0x10000000 is bit 3 of CR0

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth16.prod.mesa1.secureserver.net
	(smtpauth16.prod.mesa1.secureserver.net [64.202.165.22])
	by ozlabs.org (Postfix) with SMTP id 06C11DDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Sep 2008 07:11:43 +1000 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1.1220580004.22796.linuxppc-embedded@ozlabs.org>
Subject: 1MB alignment dma_alloc question
Date: Fri, 5 Sep 2008 14:11:31 -0700
Message-ID: <CBF4EB06A92A4901B32659109487513E@absolutdaddy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1.1220580004.22796.linuxppc-embedded@ozlabs.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anyone,

Putting together a driver, IMA for ATM in a MPC83xx. Anyway the manual
states that one of the data structures for the QE needs to be allocated on a
1MB boundary in external memory.

Normally these come in 128/64/32byte boundaries and are easy to self align,
with some bit logic. However, after reading up on dma_alloc_coherent I see
that a limitation is that dma cannot span 64K page boundaries.

So this begs a question is their a better way to get a 1MB aligned table?
Other than allocating almost 2MB of memory and then trying to mask off the
LSBs? Seems like an awful waste of memory. I guess the real question is
there a better kernel call that returns already aligned DMA memory?

Thanks,

-Russ

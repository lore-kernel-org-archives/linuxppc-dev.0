Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17799.31574.736052.865096@cargo.ozlabs.ibm.com>
Date: Tue, 19 Dec 2006 16:40:38 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 3/3] powerpc: fix comment in kernel/irq.c
In-Reply-To: <20061213123945.859071000@sipsolutions.net>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.859071000@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> numbers, but this is actually dependent on configuration options now.
> Replace by NO_IRQ and NO_IRQ_ENABLED.

Hmmm, NO_IRQ has to be 0, if anything, per decree of the head penguin.

Paul.

Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6249B7136
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2011 07:15:32 +1100 (EST)
Message-ID: <4D6C0275.6000807@embedded-sol.com>
Date: Mon, 28 Feb 2011 22:15:49 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
References: <4D6BEDCE.3020102@embedded-sol.com>
	<20110228195350.GA31428@ovro.caltech.edu>
In-Reply-To: <20110228195350.GA31428@ovro.caltech.edu>
Content-Type: multipart/mixed; boundary="------------020505070800090506050009"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020505070800090506050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ira,

> Thank you very much Felix. The dmesg output shows that the controller
> never got an interrupt for the second transaction. The patch below has
> extra debugging information that may help determine why this happens.
> Please apply it and re-run the test.
>
> The last section of dmesg (after "Freeing unused kernel memory") is all
> I need.
>

Attached relevant dmesg portion.

Felix.

--------------020505070800090506050009
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

Freeing unused kernel memory: 136k init
__dma_request_channel: success (dma0chan0)
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd000 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd060 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd0c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd120 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd180 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd1e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd240 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd2a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd300 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: start=0
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: end=9
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0x6
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-segment INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: controller not idle!
of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0xa
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-segment INT
of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan0: completed_cookie=9
of:fsl-elo-dma ffe0c300.dma: chan0: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd000 callback
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd000 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd060 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd0c0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd120 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd180 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd1e0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd240 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd2a0 free
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd300 free
of:fsl-elo-dma ffe0c300.dma: chan0: tasklet exit
dma0chan0-copy0: verifying source buffer...
dma0chan0-copy0: verifying dest buffer...
dma0chan0-copy0: #0: No errors with src_off=0x12b2 dst_off=0x1d7d len=0x2065
dma0chan0-copy0: terminating after 1 tests, 0 failures (status 0)
dmatest: Started 2 threads using dma0chan0
private_candidate: dma0chan0 busy
__dma_request_channel: success (dma0chan1)
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd300 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd2a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd240 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd1e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: LD ef2cd180 allocated
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: start=9
of:fsl-elo-dma ffe0c300.dma: chan0: assign cookies: end=14
of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca000 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca060 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca0c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca120 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca180 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: assign cookies: start=0
of:fsl-elo-dma ffe0c300.dma: chan1: assign cookies: end=5
of:fsl-elo-dma ffe0c300.dma: chan1: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan1: irq: stat = 0x6
of:fsl-elo-dma ffe0c300.dma: chan1: irq: End-of-segment INT
of:fsl-elo-dma ffe0c300.dma: chan1: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan1: irq: stat = 0xa
of:fsl-elo-dma ffe0c300.dma: chan1: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan1: irq: End-of-segment INT
of:fsl-elo-dma ffe0c300.dma: chan1: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan1: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan1: completed_cookie=5
of:fsl-elo-dma ffe0c300.dma: chan1: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca000 callback
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca000 free
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca060 free
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca0c0 free
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca120 free
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca180 free
of:fsl-elo-dma ffe0c300.dma: chan1: tasklet exit
dma0chan1-copy0: verifying source buffer...
dma0chan1-copy0: verifying dest buffer...
dma0chan1-copy0: #0: No errors with src_off=0x1abf dst_off=0x240 len=0x1079
dma0chan1-copy0: terminating after 1 tests, 0 failures (status 0)
dmatest: Started 2 threads using dma0chan1
private_candidate: dma0chan0 busy
private_candidate: dma0chan1 busy
__dma_request_channel: success (dma0chan2)
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca180 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca120 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca0c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca060 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca000 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca1e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca240 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca2a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: LD ef2ca300 allocated
of:fsl-elo-dma ffe0c300.dma: chan1: assign cookies: start=5
of:fsl-elo-dma ffe0c300.dma: chan1: assign cookies: end=14
of:fsl-elo-dma ffe0c300.dma: chan1: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d000 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: assign cookies: start=0
of:fsl-elo-dma ffe0c300.dma: chan2: assign cookies: end=1
of:fsl-elo-dma ffe0c300.dma: chan2: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan2: irq: stat = 0xa
of:fsl-elo-dma ffe0c300.dma: chan2: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan2: irq: End-of-segment INT
of:fsl-elo-dma ffe0c300.dma: chan2: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan2: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan2: completed_cookie=1
of:fsl-elo-dma ffe0c300.dma: chan2: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d000 callback
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d000 free
of:fsl-elo-dma ffe0c300.dma: chan2: tasklet exit
dma0chan2-copy0: verifying source buffer...
dma0chan2-copy0: verifying dest buffer...
dma0chan2-copy0: #0: No errors with src_off=0x1837 dst_off=0x3bac len=0x73
dma0chan2-copy0: terminating after 1 tests, 0 failures (status 0)
dmatest: Started 2 threads using dma0chan2
private_candidate: dma0chan0 busy
private_candidate: dma0chan1 busy
private_candidate: dma0chan2 busy
__dma_request_channel: success (dma0chan3)
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d000 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d060 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d0c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d120 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d180 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d1e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d240 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: LD ef34d2a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan2: assign cookies: start=1
of:fsl-elo-dma ffe0c300.dma: chan2: assign cookies: end=9
of:fsl-elo-dma ffe0c300.dma: chan2: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338000 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338060 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef3380c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338120 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: assign cookies: start=0
of:fsl-elo-dma ffe0c300.dma: chan3: assign cookies: end=4
of:fsl-elo-dma ffe0c300.dma: chan3: idle, starting controller
of:fsl-elo-dma ffe0c300.dma: chan3: irq: stat = 0x6
of:fsl-elo-dma ffe0c300.dma: chan3: irq: End-of-segment INT
of:fsl-elo-dma ffe0c300.dma: chan3: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan3: irq: stat = 0xa
of:fsl-elo-dma ffe0c300.dma: chan3: irq: End-of-link INT
of:fsl-elo-dma ffe0c300.dma: chan3: irq: End-of-segment INT
of:fsl-elo-dma ffe0c300.dma: chan3: irq: Exit
of:fsl-elo-dma ffe0c300.dma: chan3: tasklet entry
of:fsl-elo-dma ffe0c300.dma: chan3: completed_cookie=4
of:fsl-elo-dma ffe0c300.dma: chan3: no pending LDs
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338000 callback
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338000 free
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338060 free
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef3380c0 free
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338120 free
of:fsl-elo-dma ffe0c300.dma: chan3: tasklet exit
dmatest: Started 2 threads using dma0chan3
private_candidate: dma0chan0 busy
private_candidate: dma0chan1 busy
private_candidate: dma0chan2 busy
private_candidate: dma0chan3 busy
__dma_request_channel: success (dma1chan0)
dma0chan3-copy0: verifying source buffer...
dma0chan3-copy0: verifying dest buffer...
dma0chan3-copy0: #0: No errors with src_off=0x13a6 dst_off=0xd9c len=0xf40
dma0chan3-copy0: terminating after 1 tests, 0 failures (status 0)
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338120 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef3380c0 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338060 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338000 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338180 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef3381e0 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef338240 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: LD ef3382a0 allocated
of:fsl-elo-dma ffe0c300.dma: chan3: assign cookies: start=4
of:fsl-elo-dma ffe0c300.dma: chan3: assign cookies: end=12
of:fsl-elo-dma ffe0c300.dma: chan3: idle, starting controller
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3000 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3060 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b30c0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3120 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3180 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b31e0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3240 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b32a0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3300 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3360 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b33c0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: assign cookies: start=0
of:fsl-elo-dma ffe21300.dma: chan0: assign cookies: end=11
of:fsl-elo-dma ffe21300.dma: chan0: idle, starting controller
of:fsl-elo-dma ffe21300.dma: chan0: irq: stat = 0x6
of:fsl-elo-dma ffe21300.dma: chan0: irq: End-of-segment INT
of:fsl-elo-dma ffe21300.dma: chan0: irq: controller not idle!
of:fsl-elo-dma ffe21300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe21300.dma: chan0: irq: stat = 0xa
of:fsl-elo-dma ffe21300.dma: chan0: irq: End-of-link INT
of:fsl-elo-dma ffe21300.dma: chan0: irq: End-of-segment INT
of:fsl-elo-dma ffe21300.dma: chan0: irq: Exit
of:fsl-elo-dma ffe21300.dma: chan0: tasklet entry
of:fsl-elo-dma ffe21300.dma: chan0: completed_cookie=11
of:fsl-elo-dma ffe21300.dma: chan0: no pending LDs
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3000 callback
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3000 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3060 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b30c0 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3120 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3180 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b31e0 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3240 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b32a0 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3300 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3360 free
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b33c0 free
of:fsl-elo-dma ffe21300.dma: chan0: tasklet exit
dma1chan0-copy0: verifying source buffer...
dma1chan0-copy0: verifying dest buffer...
dma1chan0-copy0: #0: No errors with src_off=0x63a dst_off=0x1342 len=0x28b3
dma1chan0-copy0: terminating after 1 tests, 0 failures (status 0)
dmatest: Started 2 threads using dma1chan0
private_candidate: dma0chan0 busy
private_candidate: dma0chan1 busy
private_candidate: dma0chan2 busy
private_candidate: dma0chan3 busy
private_candidate: dma1chan0 busy
__dma_request_channel: success (dma1chan1)
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b33c0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3360 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3300 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b32a0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3240 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b31e0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3180 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3120 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b30c0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3060 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3000 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3420 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b3480 allocated
of:fsl-elo-dma ffe21300.dma: chan0: LD ef3b34e0 allocated
of:fsl-elo-dma ffe21300.dma: chan0: assign cookies: start=11
of:fsl-elo-dma ffe21300.dma: chan0: assign cookies: end=25
of:fsl-elo-dma ffe21300.dma: chan0: idle, starting controller
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae000 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae060 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae0c0 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae120 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae180 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae1e0 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae240 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae2a0 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae300 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae360 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae3c0 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae420 allocated
of:fsl-elo-dma ffe21300.dma: chan1: assign cookies: start=0
of:fsl-elo-dma ffe21300.dma: chan1: assign cookies: end=12
of:fsl-elo-dma ffe21300.dma: chan1: idle, starting controller
of:fsl-elo-dma ffe21300.dma: chan1: irq: stat = 0x6
of:fsl-elo-dma ffe21300.dma: chan1: irq: End-of-segment INT
of:fsl-elo-dma ffe21300.dma: chan1: irq: controller not idle!
of:fsl-elo-dma ffe21300.dma: chan1: irq: Exit
of:fsl-elo-dma ffe21300.dma: chan1: irq: stat = 0xa
of:fsl-elo-dma ffe21300.dma: chan1: irq: End-of-link INT
of:fsl-elo-dma ffe21300.dma: chan1: irq: End-of-segment INT
of:fsl-elo-dma ffe21300.dma: chan1: irq: Exit
of:fsl-elo-dma ffe21300.dma: chan1: tasklet entry
of:fsl-elo-dma ffe21300.dma: chan1: completed_cookie=12
of:fsl-elo-dma ffe21300.dma: chan1: no pending LDs
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae000 callback
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae000 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae060 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae0c0 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae120 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae180 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae1e0 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae240 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae2a0 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae300 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae360 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae3c0 free
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae420 free
of:fsl-elo-dma ffe21300.dma: chan1: tasklet exit
dmatest: Started 2 threads using dma1chan1
private_candidate: dma0chan0 busy
private_candidate: dma0chan1 busy
private_candidate: dma0chan2 busy
private_candidate: dma0chan3 busy
private_candidate: dma1chan0 busy
private_candidate: dma1chan1 busy
__dma_request_channel: success (dma1chan2)
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae420 allocated
of:fsl-elo-dma ffe21300.dma: chan1: LD ef3ae3c0 allocated
of:fsl-elo-dma ffe21300.dma: chan1: assign cookies: start=12
of:fsl-elo-dma ffe21300.dma: chan1: assign cookies: end=14
of:fsl-elo-dma ffe21300.dma: chan1: idle, starting controller
dma1chan1-copy0: verifying source buffer...
dma1chan1-copy0: verifying dest buffer...
dma1chan1-copy0: #0: No errors with src_off=0x6d7 dst_off=0xdd6 len=0x2bad
dma1chan1-copy0: terminating after 1 tests, 0 failures (status 0)
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b000 allocated
of:fsl-elo-dma ffe21300.dma: chan2: assign cookies: start=0
of:fsl-elo-dma ffe21300.dma: chan2: assign cookies: end=1
of:fsl-elo-dma ffe21300.dma: chan2: idle, starting controller
of:fsl-elo-dma ffe21300.dma: chan2: irq: stat = 0xa
of:fsl-elo-dma ffe21300.dma: chan2: irq: End-of-link INT
of:fsl-elo-dma ffe21300.dma: chan2: irq: End-of-segment INT
of:fsl-elo-dma ffe21300.dma: chan2: irq: Exit
of:fsl-elo-dma ffe21300.dma: chan2: tasklet entry
of:fsl-elo-dma ffe21300.dma: chan2: completed_cookie=1
of:fsl-elo-dma ffe21300.dma: chan2: no pending LDs
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b000 callback
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b000 free
of:fsl-elo-dma ffe21300.dma: chan2: tasklet exit
dmatest: Started 2 threads using dma1chan2
private_candidate: dma0chan0 busy
private_candidate: dma0chan1 busy
private_candidate: dma0chan2 busy
private_candidate: dma0chan3 busy
private_candidate: dma1chan0 busy
private_candidate: dma1chan1 busy
private_candidate: dma1chan2 busy
__dma_request_channel: success (dma1chan3)
dma1chan2-copy0: verifying source buffer...
dma1chan2-copy0: verifying dest buffer...
dma1chan2-copy0: #0: No errors with src_off=0x39c9 dst_off=0x2def len=0x5c
dma1chan2-copy0: terminating after 1 tests, 0 failures (status 0)
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b000 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b060 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b0c0 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b120 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b180 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b1e0 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b240 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b2a0 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b300 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b360 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b3c0 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b420 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b480 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b4e0 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b540 allocated
of:fsl-elo-dma ffe21300.dma: chan2: LD ef37b5a0 allocated
of:fsl-elo-dma ffe21300.dma: chan2: assign cookies: start=1
of:fsl-elo-dma ffe21300.dma: chan2: assign cookies: end=17
of:fsl-elo-dma ffe21300.dma: chan2: idle, starting controller
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af000 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af060 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af0c0 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af120 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af180 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af1e0 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af240 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af2a0 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af300 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af360 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af3c0 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af420 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af480 allocated
of:fsl-elo-dma ffe21300.dma: chan3: assign cookies: start=0
of:fsl-elo-dma ffe21300.dma: chan3: assign cookies: end=13
of:fsl-elo-dma ffe21300.dma: chan3: idle, starting controller
of:fsl-elo-dma ffe21300.dma: chan3: irq: stat = 0x6
of:fsl-elo-dma ffe21300.dma: chan3: irq: End-of-segment INT
of:fsl-elo-dma ffe21300.dma: chan3: irq: controller not idle!
of:fsl-elo-dma ffe21300.dma: chan3: irq: Exit
of:fsl-elo-dma ffe21300.dma: chan3: irq: stat = 0xa
of:fsl-elo-dma ffe21300.dma: chan3: irq: End-of-link INT
of:fsl-elo-dma ffe21300.dma: chan3: irq: End-of-segment INT
of:fsl-elo-dma ffe21300.dma: chan3: irq: Exit
of:fsl-elo-dma ffe21300.dma: chan3: tasklet entry
of:fsl-elo-dma ffe21300.dma: chan3: completed_cookie=13
of:fsl-elo-dma ffe21300.dma: chan3: no pending LDs
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af000 callback
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af000 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af060 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af0c0 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af120 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af180 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af1e0 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af240 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af2a0 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af300 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af360 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af3c0 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af420 free
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af480 free
of:fsl-elo-dma ffe21300.dma: chan3: tasklet exit
dmatest: Started 2 threads using dma1chan3
private_candidate: dma0chan0 busy
private_candidate: dma0chan1 busy
private_candidate: dma0chan2 busy
private_candidate: dma0chan3 busy
private_candidate: dma1chan0 busy
private_candidate: dma1chan1 busy
private_candidate: dma1chan2 busy
private_candidate: dma1chan3 busy
__dma_request_channel: fail ((null))
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af480 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af420 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af3c0 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af360 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af300 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af2a0 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af240 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af1e0 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af180 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af120 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af0c0 allocated
of:fsl-elo-dma ffe21300.dma: chan3: LD ef3af060 allocated
of:fsl-elo-dma ffe21300.dma: chan3: assign cookies: start=13
of:fsl-elo-dma ffe21300.dma: chan3: assign cookies: end=25
of:fsl-elo-dma ffe21300.dma: chan3: idle, starting controller
dma1chan3-copy0: verifying source buffer...
dma1chan3-copy0: verifying dest buffer...
dma1chan3-copy0: #0: No errors with src_off=0x751 dst_off=0x5a0 len=0x3084
dma1chan3-copy0: terminating after 1 tests, 0 failures (status 0)
dma0chan0-copy1: #0: test timed out
dma0chan0-copy1: terminating after 1 tests, 1 failures (status 0)
dma0chan1-copy1: #0: test timed out
dma0chan1-copy1: terminating after 1 tests, 1 failures (status 0)
dma0chan2-copy1: #0: test timed out
dma0chan2-copy1: terminating after 1 tests, 1 failures (status 0)
dma0chan3-copy1: #0: test timed out
dma0chan3-copy1: terminating after 1 tests, 1 failures (status 0)
dma1chan0-copy1: #0: test timed out
dma1chan0-copy1: terminating after 1 tests, 1 failures (status 0)
dma1chan1-copy1: #0: test timed out
dma1chan1-copy1: terminating after 1 tests, 1 failures (status 0)
dma1chan2-copy1: #0: test timed out
dma1chan2-copy1: terminating after 1 tests, 1 failures (status 0)
dma1chan3-copy1: #0: test timed out
dma1chan3-copy1: terminating after 1 tests, 1 failures (status 0)

--------------020505070800090506050009--

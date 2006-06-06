Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 79CBE67B6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 20:06:00 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k56AGTlI003590
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Jun 2006 03:16:29 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k56A5uSU003303
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Jun 2006 05:05:57 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730814A3@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'salvatore cusenza'" <salvatore.cusenza@gmail.com>,
	linuxppc-embedded@ozlabs.org
Subject: RE: eth0: tx queue full
Date: Tue, 6 Jun 2006 18:05:48 +0800 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Can you repeat the problem?  Kernel 2.4.20 is considerable old even for 
2.4 series.  Could you try to replace the fec driver from latest 2.4 kernel?

Best Regards,
Leo

> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org] On Behalf
> Of salvatore cusenza
> Sent: Tuesday, June 06, 2006 4:14 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: eth0: tx queue full
> 
> At runtime during the usual life of my board (MPC852 and linux-2.4.20 Denk's
> distribution)
>  I have experienced the following crash:
> 
> 
> eth0: tx queue full!.
> eth0: tx queue full!.
> eth0: tx queue full!.
> 
> Oops: kernel access of bad area, sig: 11
> NIP: C000D440 XER: 00000000 LR: C00BB040 SP: C0C9BC10 REGS: c0c9bb60 TRAP: 0300
> Tainted: P
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00001F9D, DSISR: 000000E4
> TASK = c0c9a000[145] 'L5421' Last syscall: 4
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C0C9BC10 C0C9A000 C0F56D70 00001F99 0000003C C0F56D6C 00000007
> GPR08: 00000001 0000003C 00000000 C0F56DB0 C0D83C3C 10071D28 00000000 C3120000
> GPR16: C311CB04 C311C8D8 C311C754 C0170000 C3120000 C311CB30 00000001 C0169DA0
> GPR24: F0000E00 00001F9D C0F58400 0000003C 00000040 C2080100 C0F58200 C0F501B0
> Call backtrace:
> C00BAF8C C00BABC8 C0005848 C3119448 C31194C0 C31194F8 C00066F8
> C0011A48 C00BA8FC C00CADD8 C00C3F00 C0016B50 C00AFE4C C00B4B94
> C00B5EF4 C003571C C000457C 0FFD5E4C 0FEDB8DC 0FEDB284 1003B5B8
> 1003D558 1003A88C 0FED34A4 0FED32D0 0FFCFEE4 0FD5F590
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  <0>Rebooting in 180 seconds..
> 
> 
> Could you suggest me something to investigate?
> 

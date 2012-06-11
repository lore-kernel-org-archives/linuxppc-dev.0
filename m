Return-Path: <r58472@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E980B6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2012 19:37:02 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Gopalakrishnan Raman <graman@arubanetworks.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: Question about MPIC_SINGLE_DEST_CPU on P1020 (e500 core) SMP
Date: Mon, 11 Jun 2012 09:36:53 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0933CC31@039-SN2MPN1-022.039d.mgd.msft.net>
References: <802E1C77E421D345A43385A6BFAC7AC4BE502C@ROYALGORGE.arubanetworks.com>
In-Reply-To: <802E1C77E421D345A43385A6BFAC7AC4BE502C@ROYALGORGE.arubanetworks.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "rgkwstl@gmail.com" <rgkwstl@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Subject: Question about MPIC_SINGLE_DEST_CPU on P1020 (e500 core) SMP
>=20
> Hi
> The P1020 manual states (in the PIC chapter) that in the "Internal
> Interrupt Destination" register, only 1 CPU (and not both) can be
> selected as the IRQ destination. How then can we achieve "interrupt
> spraying" for the PCI interrupt (we want interrupts to be sent
> alternately to CPU0 and CPU1). Also, =A0we changed the code to ignore the
> MPIC_SINGLE_DEST_CPU flag and set both CPUs in the destination of the
> PIC_IIDRn register. This does seem to work. But we're not sure if we can
> rely on this behavior and whether it will cause other problems.

I suggest you to follow the UM.  The note should be there for a reason alth=
ough personally I don't know what the specific problem will be.

Leo

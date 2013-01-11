Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1031E2C032C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2013 05:16:27 +1100 (EST)
Date: Fri, 11 Jan 2013 12:16:11 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Interrupt handler not executed
To: <R.Patil@mei-india.com>
References: <OFFE4470AC.C2444613-ON65257AF0.0029CACD-65257AF0.0029CAD8@LocalDomain>
In-Reply-To: <OFFE4470AC.C2444613-ON65257AF0.0029CACD-65257AF0.0029CAD8@LocalDomain>
 (from R.Patil@mei-india.com on Fri Jan 11 01:36:29 2013)
Message-ID: <1357928171.5475.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/11/2013 01:36:29 AM, R.Patil@mei-india.com wrote:
> Hello,
>=20
> We are working on board based on Freescale MPC8313ERDB. We have =20
> ported linux 3.0.46 kernel on it. In one of device driver written by =20
> us, we need to take some action upon asserting IRQ0 interrupt. For =20
> this we have written interrupt handler which takes care of this. We =20
> are able register interrupt handler successfully with the help of =20
> 'request_irq'. We confirmed this by checking respective entry in =20
> '/proc/interrupts'. We have also confirmed assertion of interrupt =20
> line (IRQ0) on oscilloscope. The problem is, interrupt handler does =20
> not execute upon asserting the interrupt line.

What IRQ number did you pass to request_irq()?  request_irq() takes =20
virtual interrupt numbers, not anything out of the chip manual.

If that's not the issue, is the interrupt configured properly for level =20
and sense?

-Scott=

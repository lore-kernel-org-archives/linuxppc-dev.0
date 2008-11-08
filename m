Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [204.133.123.27])
	by ozlabs.org (Postfix) with ESMTP id 09570DDDFF
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 23:41:15 +1100 (EST)
Message-ID: <491586E3.4090709@mlbassoc.com>
Date: Sat, 08 Nov 2008 05:32:35 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Nick <ndroogh@rogers.com>
Subject: Re: MPC5200B and the CAN interface
References: <390471.16163.qm@web88105.mail.re2.yahoo.com>
In-Reply-To: <390471.16163.qm@web88105.mail.re2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick wrote:
> Hi Everyone,
> 
> I am looking for information on how to use the CAN driver for the MPC5200b.  I have built the kernel (2.6.27) with the MPC5200b can bus drivers and I see them being initialized on start up.
> 
> [   37.122041] can: controller area network core (rev 20071116 abi 8)
> [   37.128687] NET: Registered protocol family 29
> [   37.133379] can: raw protocol (rev 20071116)
> [   37.137807] can: broadcast manager protocol (rev 20080415)

I'm pretty sure this is just the SocketCAN interface.

You still need a hardware driver (and one which is SocketCAN compatible).
I don't see such a driver for the MSCAN (the hardware on the MPC5200) in
the stock 2.6.27 tree.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

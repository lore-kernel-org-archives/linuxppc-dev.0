Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB333B7025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 08:50:26 +1000 (EST)
Message-ID: <4F8367A6.3020105@freescale.com>
Date: Mon, 9 Apr 2012 17:50:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: dimitar <divanov@nateurope.com>
Subject: Re: P4080 Device tree
References: <4F7B056F.8010100@nateurope.com>
In-Reply-To: <4F7B056F.8010100@nateurope.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2012 09:13 AM, dimitar wrote:
> Hello,
> 
> I hope I'm posting my question on the right place.
> Please be gentle to me, since I'm newbie in Linux Kernel.
> 
> I'm porting Linux to a custom board based on P4080DS BSP. My problem is
> that I cannot understand the configuration of th DPA in the device tree
> including QMAN, BMAN and FMAN.

None of the datapath stuff is in mainline Linux yet -- for BSP support
you should ask support@freescale.com (or your sales/FAE/etc. contact).

-Scott

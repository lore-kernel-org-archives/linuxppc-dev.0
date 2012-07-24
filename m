Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58E3A2C0099
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 07:45:52 +1000 (EST)
Message-ID: <500F178A.6000107@freescale.com>
Date: Tue, 24 Jul 2012 16:45:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500F1165.9040404@freescale.com>
 <500F144D.5080508@freescale.com> <500F1545.1020705@freescale.com>
 <500F16B6.1080605@freescale.com> <500F1717.6040900@freescale.com>
In-Reply-To: <500F1717.6040900@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2012 04:43 PM, Timur Tabi wrote:
> Scott Wood wrote:
> 
>> Yeah, the code's there, but not the wrong compatible string for P5040.
> 
> I wasn't talking about the P5040DS specifically.
> 
> My point was that we cannot get rid of the compatible string outright
> because U-Boot uses it.

I thought we were specifically talking about what to set the P5040 PCIe
compatible stringlist to.

-Scott

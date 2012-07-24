Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E19052C0083
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 07:44:02 +1000 (EST)
Message-ID: <500F1717.6040900@freescale.com>
Date: Tue, 24 Jul 2012 16:43:51 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com> <500F1165.9040404@freescale.com>
 <500F144D.5080508@freescale.com> <500F1545.1020705@freescale.com>
 <500F16B6.1080605@freescale.com>
In-Reply-To: <500F16B6.1080605@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:

> Yeah, the code's there, but not the wrong compatible string for P5040.

I wasn't talking about the P5040DS specifically.

My point was that we cannot get rid of the compatible string outright
because U-Boot uses it.

-- 
Timur Tabi
Linux kernel developer at Freescale

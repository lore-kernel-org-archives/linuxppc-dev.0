Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 705162C008E
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 06:16:28 +1000 (EST)
Message-ID: <500F0292.4040402@freescale.com>
Date: Tue, 24 Jul 2012 15:16:18 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com>
In-Reply-To: <500EE1BB.6060104@freescale.com>
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
>> > +		flash@0,0 {
>> > +			compatible = "cfi-flash";
>> > +			reg = <0 0 0x08000000>;
>> > +			bank-width = <2>;
>> > +			device-width = <2>;
>> > +		};
> No partitions on NOR flash?

None of the CoreNet device trees include NOR flash partitions.

-- 
Timur Tabi
Linux kernel developer at Freescale

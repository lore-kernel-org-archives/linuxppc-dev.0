Return-Path: <eddy.petrisor@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.193])
	by ozlabs.org (Postfix) with ESMTP id 03A1A6879F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2005 10:28:40 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id x30so466634nfb
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2005 15:28:39 -0800 (PST)
Message-ID: <437BBEFC.1020602@gmail.com>
Date: Thu, 17 Nov 2005 01:21:32 +0200
From: Eddy Petrisor <eddy.petrisor@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1130999620.4680.28.camel@gaston>	
	<20051116180925.GB3080@localhost>
	<1132174868.5646.112.camel@gaston>
In-Reply-To: <1132174868.5646.112.camel@gaston>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2005-11-16 at 19:09 +0100, Wolfgang Pfeiffer wrote:
> 
>>>For those who experience crashes on sleep and/or wakeup (typically due
>>>to USB) with 2.6.14, I made a test patch that might help. [ ... ]

> Only newer machines with a NEC USB2 chip that shares interrupts appear
> to be affected by the problem.

So is there any chance that the sleep issue is fixed until 2.6.15?

-- 
Regards,
EddyP
=============================================
"Imagination is more important than knowledge" A.Einstein

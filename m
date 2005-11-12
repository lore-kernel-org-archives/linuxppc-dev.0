Return-Path: <eddy.petrisor@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id 9552768714
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 20:39:37 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i11so335452wra
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 01:39:36 -0800 (PST)
Message-ID: <4375ADA5.2080305@gmail.com>
Date: Sat, 12 Nov 2005 10:53:57 +0200
From: Eddy Petrisor <eddy.petrisor@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1130999620.4680.28.camel@gaston>	
	<51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>	
	<1131229041.5229.29.camel@gaston> <43751182.1020009@gmail.com>
	<1131745946.24637.251.camel@gaston>
In-Reply-To: <1131745946.24637.251.camel@gaston>
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
> The latest patch that is candidate for upstream is:
> 
> Index: 2.6.14-ben/drivers/usb/core/hcd-pci.c

This version also panics :(

-- 
Regards,
EddyP
=============================================
"Imagination is more important than knowledge" A.Einstein

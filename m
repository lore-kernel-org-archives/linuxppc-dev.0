Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 6D198B7B77
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 02:10:18 +1000 (EST)
Message-ID: <4AB25FB0.2080007@embeddedarm.com>
Date: Thu, 17 Sep 2009 09:11:28 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PPC PCI bus registers
References: <4A9F0377.1070606@embeddedarm.com>	
	<1251972032.15089.30.camel@pasglop>
	<4AB13550.1070506@embeddedarm.com>	
	<1253138086.8375.290.camel@pasglop>
	<4AB16292.9020704@embeddedarm.com>
	<1253150651.8375.328.camel@pasglop>
In-Reply-To: <1253150651.8375.328.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin,

> ioremap + readN / writeN will give you fully ordered behaviour. It's
> only when you try to be sneaky or speedy and use the __raw  variants
> that you have to be more careful.

You've been most helpful, thanks.

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive              | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com

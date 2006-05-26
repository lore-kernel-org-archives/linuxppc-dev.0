Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67F5F67A6D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 16:06:01 +1000 (EST)
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <2800AE5B-623D-4F1A-99A4-A67EF89A0D77@freescale.com>
References: <9FCDBA58F226D911B202000BDBAD4673062C064E@zch01exm40.ap.freescale.net>
	<1147936929.17679.106.camel@localhost.localdomain>
	<2800AE5B-623D-4F1A-99A4-A67EF89A0D77@freescale.com>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:05:47 +1000
Message-Id: <1148623547.8089.74.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-18 at 15:49 -0500, Andy Fleming wrote:
> 
> 
> So some of this needs to be moved into u-boot (look at my patches to  
> u-boot for the 85xx CDS support, and support in the current  
> powerpc.git tree).  A lot of the PCI initialization is now there.   
> However, the interrupt maps, while properly setup in the current
> 85xx  
> u-boot oftree.dts files, is currently meaningless.  I may be wrong,  
> but I thought support for getting the map from the flat-dev tree was  
> still pending....

Well, the kernel does get the map from the tree but can't use it if the
device itself doesn't have a device-node. I'll fix that for 2.6.18
hopefully.

Ben.

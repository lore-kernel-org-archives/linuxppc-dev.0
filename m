Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 01C2567D4D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 16:07:41 +1100 (EST)
Date: Mon, 13 Nov 2006 21:07:50 -0800 (PST)
Message-Id: <20061113.210750.66175955.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
From: David Miller <davem@davemloft.net>
In-Reply-To: <1163469594.5940.42.camel@localhost.localdomain>
References: <1163405790.4982.289.camel@localhost.localdomain>
	<20061113.163138.98554015.davem@davemloft.net>
	<1163469594.5940.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: idr@us.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, anton@samba.org, airlied@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Nov 2006 12:59:54 +1100

> If I "fix" the kernel to do the right thing, that is pass BAR values in
> devices and expect BAR values in mmap, then I will break existing X
> setups on machines where PCI is not mapped 1:1 (that is mostly CHRP
> machines).
> 
> The problem I'm fixing in this patch is that while we were providing the
> hacked up value in "devices", we were expecting the BAR value in mmap,
> and there are apps expecting us to be consistent between the two, thus
> the breakage.

Ok, I don't see much alternatives for you then.  I have no real
objections to your patch.

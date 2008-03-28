Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AE56DE095
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 06:38:01 +1100 (EST)
Message-Id: <163986FE-1FE0-4FAB-AACA-6E2605CF4094@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080328164441.GA7146@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/3] mpc83xx: fix usb phy_type in mpc837x rdb device trees
Date: Fri, 28 Mar 2008 14:37:51 -0500
References: <20080328105125.6a072ff7.kim.phillips@freescale.com>
	<20080328164441.GA7146@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 28, 2008, at 11:44 AM, Anton Vorontsov wrote:
> On Fri, Mar 28, 2008 at 10:51:25AM -0500, Kim Phillips wrote:
>> the mpc837x rdb board uses low pin count interfaces (ULPI) to connect
>> to the USB PHY.
>
> I've sent this fix two weeks ago...
>
> http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052926.html
>
>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

I'll apply Anton's version and add a signed-off-by Kim.

- k

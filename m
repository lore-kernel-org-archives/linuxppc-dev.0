Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1B2F6B7CB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 20:18:42 +1100 (EST)
Date: Thu, 21 Jan 2010 01:18:52 -0800 (PST)
Message-Id: <20100121.011852.236670993.davem@davemloft.net>
To: B13201@freescale.com
Subject: Re: [PATCH 4/4] phy: add RTBI mode for m88e1111
From: David Miller <davem@davemloft.net>
In-Reply-To: <0A1FE637C2C7E148B9573BB60CC630E5711B54@zch01exm26.fsl.freescale.net>
References: <1263456799-3306-4-git-send-email-yu.liu@freescale.com>
	<BC00E67D-5906-4740-A961-84FC1C524A4F@kernel.crashing.org>
	<0A1FE637C2C7E148B9573BB60CC630E5711B54@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Liu Yu-B13201" <B13201@freescale.com>
Date: Fri, 15 Jan 2010 10:49:37 +0800

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org] 
>> Sent: Friday, January 15, 2010 12:20 AM
>> To: Liu Yu-B13201
>> Cc: davem@davemloft.net; linuxppc-dev@lists.ozlabs.org; 
>> netdev@vger.kernel.org
>> Subject: Re: [PATCH 4/4] phy: add RTBI mode for m88e1111
>> 
>> 
>> Does this magic 0x7 have some meaning?
>> 
> 
> Hrr...  it's GMII to fibre mode.
> Document 88E1111_erata_RevB2  chapter 4.35 describ the reason.
> Without this sometimes phys couldnot work.

Just FYI, I've applied all of these patches to net-next-2.6

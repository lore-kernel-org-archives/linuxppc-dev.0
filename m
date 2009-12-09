Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B89D8B7093
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 08:58:45 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB9LwgFB016403
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Dec 2009 14:58:42 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nB9M3kjs026897
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Dec 2009 16:03:47 -0600 (CST)
Message-ID: <4B201D67.4070802@freescale.com>
Date: Wed, 09 Dec 2009 15:57:59 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2] cpm2_pic: Allow correct flow_types for port C
	interrupts
References: <4B1EF3E9.8050005@elphinstone.net>
	<20091209215334.GA536@oksana.dev.rtsoft.ru>
In-Reply-To: <20091209215334.GA536@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Mark Ware <mware@elphinstone.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
>> +		if ((flow_type != IRQ_TYPE_EDGE_BOTH) && 
>> +			(flow_type != IRQ_TYPE_EDGE_FALLING)) {
> 
> I'd place one more tab here.

Or better, align one "flow_type" with the other.

-Scott

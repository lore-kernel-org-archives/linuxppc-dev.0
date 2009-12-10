Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D23BEB80D9
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 04:42:23 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBAHgLZB024312
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 10:42:21 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nBAHgNSP003484
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 11:42:23 -0600 (CST)
Message-ID: <4B2132D2.6000207@freescale.com>
Date: Thu, 10 Dec 2009 11:41:38 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3] cpm2_pic: Allow correct flow_types for port
	C	interrupts
References: <4B20D81A.7010503@elphinstone.net>	<9DDC31C7-6AEE-498C-BE18-C286C950BB51@kernel.crashing.org>
	<20091210145808.GA16421@oksana.dev.rtsoft.ru>
In-Reply-To: <20091210145808.GA16421@oksana.dev.rtsoft.ru>
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
> On Thu, Dec 10, 2009 at 08:52:01AM -0600, Kumar Gala wrote:
>> On Dec 10, 2009, at 5:14 AM, Mark Ware wrote:
>>
>>> Port C interrupts can be either falling edge, or either edge.
>>> Other external interrupts are either falling edge or active low.
>>> Tested on a custom 8280 based board.
>>>
>>> Signed-off-by: Mark Ware <mware@elphinstone.net>
>>> ---
>>> Changed in v3:
>>> - Cosmetic improvements as suggested by Anton and Scott
>>> - Added tested note to changelog
>>>
>>> arch/powerpc/sysdev/cpm2_pic.c |   28 +++++++++++++++++++++-------
>>> 1 files changed, 21 insertions(+), 7 deletions(-)
>> Scott, Anton do you want to add an Ack to this version?
> 
> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott

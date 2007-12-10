Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA997DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 10:26:44 +1100 (EST)
Message-ID: <475DCB45.3090306@freescale.com>
Date: Mon, 10 Dec 2007 17:27:01 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/3] Use embedded libfdt in the bootwrapper
References: <20071210032343.GB29611@localhost.localdomain>
	<20071210032839.71412DDDFA@ozlabs.org>
	<20071210173217.GB4497@loki.buserror.net>
	<20071210231056.GC5495@localhost.localdomain>
	<475DC966.6070301@freescale.com>
In-Reply-To: <475DC966.6070301@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> David Gibson wrote:
>> On Mon, Dec 10, 2007 at 11:32:17AM -0600, Scott Wood wrote:
>>> How does using offsets as devps work if a devp was previously
>>> acquired to a node that has to be moved due to a change later made
>>> in an earlier part of the tree?
>>
>> It doesn't; don't do that.  I just don't think truly persistent 
>> phandles are worth the code complexity to implement them.
[snip]
> It breaks the extremely common and useful usage of:
> 
> devp = create node;
> setprop(devp, "foo", something);
> setprop(devp, "bar", something);

BTW, there's code in devtree.c with your name on it that does exactly 
this. :-)

-Scott

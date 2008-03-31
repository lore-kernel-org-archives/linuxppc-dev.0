Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA116DE036
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 03:42:37 +1000 (EST)
Message-ID: <47F12287.5030503@freescale.com>
Date: Mon, 31 Mar 2008 12:42:31 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in
	thedevice tree.
References: <200803261217.46671.laurentp@cse-semaphore.com><200803281854.28595.laurentp@cse-semaphore.com><47ED33FC.3020107@freescale.com><200803311109.02422.laurentp@cse-semaphore.com>
	<20080331153301.GA23806@ld0162-tx32.am.freescale.net>
	<DCEAAC0833DD314AB0B58112AD99B93B043011C7@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B043011C7@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Scott Wood wrote:
>> 0x2000 minus sizeof(...) would be a good default for CPM1 and CPM2
>> (8280 has its first chunk go up to 0x4000, but for some reason that
>> didn't get reflected in the dts for the one 8280 board in-tree).
> 
> Except that last time I tested it, it is not from 0 - 0x4000, but the
> extra 0x2000 is added from offset 0x9000.....
> So 8280 has available muram from 0 - 0x2000 and 0x9000 - 0xb000

According to the docs, it has 0 - 0x4000 and 0x9000 - 0xc000.

-Scott

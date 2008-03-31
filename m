Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id BB808DDF4C
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 03:45:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in
	thedevice tree.
Date: Mon, 31 Mar 2008 12:45:27 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B043011DF@ismail.innsys.innovsys.com>
In-Reply-To: <47F12287.5030503@freescale.com>
References: <200803261217.46671.laurentp@cse-semaphore.com><200803281854.28595.laurentp@cse-semaphore.com><47ED33FC.3020107@freescale.com><200803311109.02422.laurentp@cse-semaphore.com>
	<20080331153301.GA23806@ld0162-tx32.am.freescale.net>
	<DCEAAC0833DD314AB0B58112AD99B93B043011C7@ismail.innsys.innovsys.com>
	<47F12287.5030503@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Rune Torgersen wrote:
>> Scott Wood wrote:
>>> 0x2000 minus sizeof(...) would be a good default for CPM1 and CPM2
>>> (8280 has its first chunk go up to 0x4000, but for some reason that
>>> didn't get reflected in the dts for the one 8280 board in-tree).
>>=20
>> Except that last time I tested it, it is not from 0 - 0x4000, but the
>> extra 0x2000 is added from offset 0x9000.....
>> So 8280 has available muram from 0 - 0x2000 and 0x9000 - 0xb000
>=20
> According to the docs, it has 0 - 0x4000 and 0x9000 - 0xc000.

I tried it on out 8280 board inhouse, and any addresses from 0x2000 to
0x3fff does not work with at least the MCC's.
(running ss7 with the extended ss7 microcode)
If I only used 0-0x2000 and 0x9000 to 0xB000 then it is happy.

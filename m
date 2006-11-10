Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id C8D1967F15
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 10:10:40 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Help with an MMIO register read function
Date: Sat, 11 Nov 2006 00:10:28 +0100
References: <1163199434.30540.13.camel@dyn9047021226.beaverton.ibm.com>
In-Reply-To: <1163199434.30540.13.camel@dyn9047021226.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611110010.28788.arnd@arndb.de>
Cc: Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 November 2006 23:57, Carl Love wrote:
> I expect the SBI values to be 0x2000000 =A0not 0x200000000. =A0The L2 deb=
ug
> value should be 0x6 not 0x600000000000000. =A0It seems like the bits are
> there but shifted from where I would expect them to be. =A0Anyone have any
> thoughts as to what is wrong?

Hmm, maybe you confused the bit order in the specification? IBM
counts the MSB as bit 0, while everyone else counts the LSB as
bit 0.

	Arnd <><

Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7C012BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 04:49:49 +1000 (EST)
In-Reply-To: <20041011173344.62221.qmail@web53810.mail.yahoo.com>
References: <20041011173344.62221.qmail@web53810.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A83476D0-1BB6-11D9-909B-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 11 Oct 2004 14:52:10 -0400
To: annamaya <annamaya@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 11, 2004, at 1:33 PM, annamaya wrote:

> I will try the zImage trick

It's not a trick nor magic :-)  It's required for use
with these boards because......

> ...but I just wanted to know
> if the assumption here is that the kernel already
> understands the EEPROM data format to construct
> bd_info. Is that correct?

....the kernel does not understand anything about
the EEPROM format on this board.  This is the
reason this "front end" bootloader was created.
The standard interface to the kernel is the
board descriptor, the board specific data in
the EEPROM or elsewhere is usually quite
varied and isn't appropriate to have in the
kernel when it can be easily represented in
a standard manner.

Thanks.


	-- Dan

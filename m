Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3BA82BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Nov 2004 06:51:53 +1100 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DBC9@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DBC9@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <51EED890-3CC0-11D9-8C5A-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 22 Nov 2004 14:54:29 -0500
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 19, 2004, at 9:25 AM, Rune Torgersen wrote:

> Send a patch to fix this in the driver. I think most people on this 
> list
> would like the seriaql drivers to be totally independent of the
> bootloader (no matter what it is).

The serial driver is totally independent of the bootloader.
It configures the SMC from scratch and assumes nothing of
the bootloader.  However, if the bootloader configures itself
as Linux does, then other functions like early kgdb over
serial port work properly.


	-- Dan

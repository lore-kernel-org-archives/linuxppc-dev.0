Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 5E07168864
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 05:43:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 1 Dec 2005 12:43:02 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8594B6@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Laurent Lagrange" <lagrange@fr.oleane.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: PPC 32bits and big RAM mapping problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Laurent Lagrange
> Sent: Thursday, December 01, 2005 11:48
> To: linuxppc-embedded@ozlabs.org
> Subject: PPC 32bits and big RAM mapping problem

> So I'm under the impression to be cornered in my shoes.
> Any idea, book, article, prediction would be welcome.

I have 2GB of ram working on my PPC32 board.

You have to change the following in the kernel config:
Under Advanced Setup:
	Set Maximum Low memory (Set to 0x40000000)
	Set Custom Kernel config address (Set to 0xA0000000)

I do not remember if I had to change anything else.

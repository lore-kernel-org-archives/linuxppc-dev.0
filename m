Return-Path: <runet@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Thu, 4 Nov 2004 14:57:44 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DBAA@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: dwmw2@shinybook.infradead.org, Linuxppc-embedded@ozlabs.org
Subject: RE: Possible CPM2 SMC bug
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
> From: Tom Rini [mailto:trini@kernel.crashing.org]=20
> Sent: Thursday, November 04, 2004 12:57
> It sounds like the clock rate isn't quite right on SMC1.  Any=20
> chance you've worked this problem out more?  Thanks.

Sorry, havent had any time.=20
If the clock was off, I would expect all output to be signtly garbled,
not only from init?
(or does init use some weird output stuff...)

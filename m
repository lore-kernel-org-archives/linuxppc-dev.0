Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <904F5BD9-1ACB-4936-B390-E4128886824C@kernel.crashing.org>
References: <20060429232812.825714000@localhost.localdomain>
	<200605020150.14152.arnd@arndb.de>
	<1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
	<200605021259.24157.arnd@arndb.de>
	<801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
	<17496.6519.733076.663815@cargo.ozlabs.ibm.com>
	<904F5BD9-1ACB-4936-B390-E4128886824C@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 04 May 2006 12:03:05 +1000
Message-Id: <1146708185.6652.108.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yeah, what was I thinking.  So use some platform hook instead.

You must be smoking good stuff :)

> But Arnd of course is right; if the driver (currently) only works
> on a certain platform, just mark it as such in the Makefile (erm,
> Kconfig file).

Exactly :) I don't see any point in adding hooks or ifdef's or anything
fancy like that to guard from something that doesn't exist in real life:
that is building that driver on non-cell :) Thus Kconfig is the way to
go.

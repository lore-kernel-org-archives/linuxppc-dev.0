Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18006.31742.533944.368969@cargo.ozlabs.ibm.com>
Date: Fri, 25 May 2007 16:02:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
In-Reply-To: <adf40b0a9d45728359da78fa45efab8a@kernel.crashing.org>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
	<2994f78d2591e45517247003d613bb98@kernel.crashing.org>
	<1180051272.32247.1087.camel@localhost.localdomain>
	<adf40b0a9d45728359da78fa45efab8a@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Only if you think the device tree is a configuration
> mechanism for the OS.

Well, actually, it's whatever we want it to be...

There is some value in making the device tree abstract and general,
but not an overwhelming value that trumps all other considerations.

Paul.

Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 24061DDE28
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 13:42:14 +1000 (EST)
Date: Fri, 1 Aug 2008 23:42:14 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Valentine Barshak" <vbarshak@ru.mvista.com>
Subject: Re: platforms/44x/warp-nand.c bogosity
Message-ID: <20080801234214.77bb5369@lappy.seanm.ca>
In-Reply-To: <48932C78.9010303@ru.mvista.com>
References: <20080801151401.GC24735@cs181140183.pp.htv.fi>
	<20080801112628.35fb0ff2@zod.rchland.ibm.com>
	<48932C78.9010303@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Adrian Bunk <bunk@kernel.org>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For those who are interested, I have posted a patch for the ndfc
driver. This is the driver we use un-bogusitize the warp-nand ;)

I removed the CONFIG_PPC_MERGE defines, but other than that this is the
driver we use in production.

Stefan: This has the byte order reversing that I believe you where
going to look into wrt u-boot. This may need to be a config option.

Cheers,
   Sean

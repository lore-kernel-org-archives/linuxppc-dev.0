Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0FD66DDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 03:27:27 +1000 (EST)
Date: Thu, 21 Aug 2008 13:27:31 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [RFC][PATCH] I2C driver
Message-ID: <20080821132731.47a2f49a@lappy.seanm.ca>
In-Reply-To: <48ADA090.8020100@harris.com>
References: <48AD9610.8090205@harris.com>
	<1219336202.26429.55.camel@jdub.homelinux.org>
	<48ADA090.8020100@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 21 Aug 2008 13:06:24 -0400
"Steven A. Falco" <sfalco@harris.com> wrote:

> However, while the i2c-ibm_of.c driver works with the sequoia .dts,
> i2c-ibm_iic.c does not, because it is looking for an "index" property,
> which is not in the .dts file.  I added one:

I don't know where i2c-ibm_of.c came from.... but in the 2.6.26 kernel
you need the index property.

The 2.6.27 kernel has a fully OF aware i2c-ibm_iic driver. You do
not need the index. And it will walk the device tree and setup the
devices for you.

Cheers,
   Sean

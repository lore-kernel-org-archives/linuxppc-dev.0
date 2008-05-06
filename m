Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 6975CDDE03
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 14:18:53 +1000 (EST)
Date: Tue, 6 May 2008 00:18:50 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <benh@kernel.crashing.org>
Subject: Re: [PATCH] Sam440ep support
Message-ID: <20080506001850.340e4e7f@lappy.seanm.ca>
In-Reply-To: <1210030608.21644.114.camel@pasglop>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<1210030608.21644.114.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Giuseppe Coviello <cjg@cruxppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 06 May 2008 09:36:48 +1000
"Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

> The IBM IIC driver should already have an of_platform_device created
> for it, so we can have here a generic driver for that chip that
> instanciates itself based on it. No need to create a platform
> device .. Or is the ibm iic host driver only in the form of a
> platform device nowadays ?

As of 2.6.26-rc1 (and I believe Josh's for-2.6.26 tree?) the ibm iic
driver is available as an of_platform driver. So you need a very recent
kernel.

However, the patches should be available in the linuxppc-dev archives if
you search for them.

Look at platforms/44x/warp.c for an example of how to initialize the
driver for the 440EP.

Cheers,
   Sean

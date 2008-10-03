Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 477C5DDE08
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 11:02:57 +1000 (EST)
Date: Thu, 2 Oct 2008 21:02:54 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Simple platform for the ISS 4xx simulator
Message-ID: <20081002210254.09076765@lappy.seanm.ca>
In-Reply-To: <20081003000737.85CFEDDE17@ozlabs.org>
References: <20081003000737.85CFEDDE17@ozlabs.org>
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

On Fri, 03 Oct 2008 10:07:19 +1000
"Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

>  image-$(CONFIG_WARP)			+= cuImage.warp
> -image-$(CONFIG_YOSEMITE)		+= cuImage.yosemite
> +image-$(CONFIG_YOSEMITE)		+= cuImage.yosemit

Did you really mean to drop the e from yosemite?

Cheers,
   Sean

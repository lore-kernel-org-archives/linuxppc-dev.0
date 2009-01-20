Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 914B3DDF86
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 15:12:08 +1100 (EST)
Date: Mon, 19 Jan 2009 23:12:05 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Warp patches for the new ndfc driver
Message-ID: <20090119231205.2378e31f@lappy.seanm.ca>
In-Reply-To: <20090109232011.19f6e780@lappy.seanm.ca>
References: <20090109232011.19f6e780@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 9 Jan 2009 23:20:11 -0500
"Sean MacLennan" <sean.maclennan@ottawa.kanatek.ca> wrote:

> Woo hoo! The ndfc driver finally got in the kernel! These patches
> update the warp to use the new driver.

Just a bump and a comment to see who is reading this ;) 

2.6.29 is a very important release for the Warp because with the
ndfc driver, and assuming this patch or something like it is accepted,
you will be able to get a working kernel for the warp from kernel.org.
It will be missing SD support and LED support, but everything else will
work :)

But it seems to me that otherwise, 2.6.29 seems to be a very quiet
release. Has anybody else noticed this?

Cheers,
   Sean

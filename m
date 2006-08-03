Return-Path: <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
From: Matthew McClintock <msm@freescale.com>
To: Li Yang <LeoLi@freescale.com>
In-Reply-To: <a0bc9bf80608030856p45870487of2646c4f9393869b@mail.gmail.com>
References: <20060802223302.9667135360F@atlas.denx.de>
	<1154618945.5094.6.camel@localhost>
	<a0bc9bf80608030856p45870487of2646c4f9393869b@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 11:02:14 -0500
Message-Id: <1154620934.5094.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 23:56 +0800, Li Yang wrote:
> 
> If U-boot supports uncompressed kernel image in uImage, I think it
> will be better to use this scheme:
> 
> u-boot header + wrapper + FDT + compressed kernel image
> 
> As kernel image will be uncompressed to its loading address directly.
> While in your proposal, it needs to be moved one more time.
> 

This is an option. But, I do not see a reason why you would not still
opt to compress everything. Especially since it is already working.
Comments anyone?

-Matthew

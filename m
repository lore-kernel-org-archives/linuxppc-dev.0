Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DABE2DDDF7
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 17:12:42 +1100 (EST)
Message-ID: <477493D9.7070700@pikatech.com>
Date: Fri, 28 Dec 2007 01:12:41 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Problems with arch/powerpc
References: <47742519.8060502@pikatech.com>
	<20071227194753.56bc92f8@vader.jdub.homelinux.org>
In-Reply-To: <20071227194753.56bc92f8@vader.jdub.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> As for the USB interrupt, you might
> be missing the device-tree enabled USB driver in your config.  The
> interrupt numbers will differ based on various things, so I wouldn't
> worry about that.
>   
Just so I am not all bad news, I got the usb going. I borrowed the usb 
config from  bamboo.dts. I then had to patch the top level usb Kconfig. 
It basically relies on PCI, and the taco has no PCI,  so I added the 
taco as a special case.

Cheers,
   Sean

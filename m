Return-Path: <jangiels@speakeasy.net>
Received: from mail4.speakeasy.net (mail4.speakeasy.net [216.254.0.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19E2E2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Dec 2004 11:34:04 +1100 (EST)
From: Jeff Angielski <jangiels@speakeasy.net>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A647439@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF0A647439@whq-msgusr-02.pit.comms.marconi.com>
Content-Type: text/plain
Message-Id: <1104452884.13899.6.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Thu, 30 Dec 2004 19:28:04 -0500
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: inflate returned FFFFFFFD - what does this error exactly mean ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2004-12-30 at 17:27, Povolotsky, Alexander wrote:
> Hi,
> 
> After few days of wondering through debugging (and with great help) I fixed
> (by inserting watch dog resets into beginning of  while loops in zlib
> functions) my first problem -strange reboot failures during decompression of
> the kernel image by the bootloader.
> However my luck expired beyond this fix so far ... ;-).
> Now I am getting "controlled" failure (during the same decompression as
> described above):

A quick suggestion would be try increase the load address that you are
using for loading the kernel image.  You might have a slight bit of
overlap that is only showing up after the memory contains non-zero
values.

Jeff Angielski

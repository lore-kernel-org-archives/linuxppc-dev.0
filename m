Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51DFFDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Oct 2007 02:20:25 +1000 (EST)
Message-ID: <46FFCD35.3000105@genesi-usa.com>
Date: Sun, 30 Sep 2007 17:22:13 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Efika, initrd and current kernel
References: <9e4733910709292205p7b1cdda9m661b241908fdedab@mail.gmail.com>	
	<46FF7A7D.6040300@genesi-usa.com>	
	<9e4733910709300709t72078992s1bad7967c565b6e1@mail.gmail.com>	
	<20070930141926.GA1431@powerlinux.fr>
	<9e4733910709300728p1f1a2c87vad38a2b047da54e0@mail.gmail.com>
In-Reply-To: <9e4733910709300728p1f1a2c87vad38a2b047da54e0@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Sven Luther <sven@genesi-usa.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

How did you attach the initrd to the kernel?

Compiled in using the initramfs feature, or did you use mkvmlinuz (debian/ubuntu)
or mkzImage (suse) or have genkernel build it (--genzimage) on Gentoo? It looks
like you're trying to boot Gentoo from the boot line..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Jon Smirl wrote:
> On 9/30/07, Sven Luther <sven@genesi-usa.com> wrote:
>> On Sun, Sep 30, 2007 at 10:09:47AM -0400, Jon Smirl wrote:
>>> On 9/30/07, Matt Sealey <matt@genesi-usa.com> wrote:
>>>> How did you build the kernel?
>>> I attached the .config
>>> Am I supposed to have both chrp and efika selected?
>> I think so, yes.
> 
> I have then both selected.
> 
> I'm sure it is something simple about how I have my kernel configured
> wrong but I can't figure out what it is. I have BLK_INITRD turned on.
> I can trace in the initrd code and see that it is exiting because
> strat_initrd is not set. start_initrd is set in the platform specfic
> code which I haven't figured out yet.
> 
> 
>> Friendly,
>>
>> Sven Luther
>>
> 
> 

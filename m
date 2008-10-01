Return-Path: <neko@genesi-usa.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 624F6DE2AD
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 23:09:28 +1000 (EST)
Received: by gxk14 with SMTP id 14so84369gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2008 06:09:26 -0700 (PDT)
Message-ID: <48E3767F.907@genesi-usa.com>
Date: Wed, 01 Oct 2008 08:09:19 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: Device Tree
References: <48E07490.9020805@enseirb.fr> <48E09108.4020400@ru.mvista.com>	
	<48E2444D.1050301@genesi-usa.com>	
	<eee4c0020809301530w20d6d1e4sd2e3542366cc595d@mail.gmail.com>	
	<48E2B16C.6030501@genesi-usa.com>
	<1222831495.12264.2.camel@pasglop>
In-Reply-To: <1222831495.12264.2.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: =?UTF-8?B?aHLDqXRpZW4=?= <chretien@enseirb.fr>, "Sébastien C"@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-09-30 at 18:08 -0500, Matt Sealey wrote:
>> It's far more common than people might think at first glance. With x86
>> I am sure it would benefit the platform a little more if the OF support
>> was in-line with the shared code between PPC and SPARC (and now I guess,
>> ARM) but nevertheless it's an Open Firmware platform and something that
>> appeared not too long ago.
>>
>> OF is still a going concern; if you want a nice flexible firmware, why
>> not use it? Most of the implementations are open source (FirmWorks and
>> CodeGen trees, and the Sun reference design) too.
> 
> And SLOF :-)

I guess OpenBIOS counts too :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Return-Path: <neko@genesi-usa.com>
Received: from mail-gx0-f14.google.com (mail-gx0-f14.google.com
	[209.85.217.14]) by ozlabs.org (Postfix) with ESMTP id 3C79C474C5
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 05:12:02 +1100 (EST)
Received: by gxk7 with SMTP id 7so11005909gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 11:12:01 -0700 (PDT)
Message-ID: <48FF6CEF.8050607@genesi-usa.com>
Date: Wed, 22 Oct 2008 13:11:59 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Extended Addressing Mode
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<48FF2DDE.9060301@genesi-usa.com>
	<DC24FCF5-F410-47AB-8FC0-592EA0906568@kernel.crashing.org>
	<48FF3685.5020504@genesi-usa.com>
	<EF781CC4-B321-4E6A-A376-ADDDC1BB2E7B@kernel.crashing.org>
In-Reply-To: <EF781CC4-B321-4E6A-A376-ADDDC1BB2E7B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Kumar Gala wrote:
> 
> On Oct 22, 2008, at 9:19 AM, Matt Sealey wrote:
> 
>>
>>
>> Kumar Gala wrote:
>>> On Oct 22, 2008, at 8:42 AM, Matt Sealey wrote:
>>>> So to confirm, XAEN support through Becky's patches does support the 
>>>> MPC8641D/e600 cores?
>>> Yes, its the only part that has XAEN.
>>
>> Okay I saw a lot of e500/BookE support go past but nothing specific :)
> 
> The "XAEN" is specific to e600.  e500 has its own ability to do 36-bit 
> physical (not called XAEN).

You have to forgive me I was only half awake when I started :D

Yeah so I saw BookE and e500 stuff go past but nothing 
specific for e600/XAEN. I mailed Becky and got no response. 
I'm glad to know it's in there though, somewhere.

Just so it has been asked, do you know in a broad sense what 
it would take to add the non-contiguous memory mapping 
support? Doesn't ppc64 already have this?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

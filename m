Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 084AFDDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 01:20:00 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so519774yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 07:19:58 -0700 (PDT)
Message-ID: <48FF3685.5020504@genesi-usa.com>
Date: Wed, 22 Oct 2008 09:19:49 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Extended Addressing Mode
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<48FF2DDE.9060301@genesi-usa.com>
	<DC24FCF5-F410-47AB-8FC0-592EA0906568@kernel.crashing.org>
In-Reply-To: <DC24FCF5-F410-47AB-8FC0-592EA0906568@kernel.crashing.org>
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
> On Oct 22, 2008, at 8:42 AM, Matt Sealey wrote:
>> So to confirm, XAEN support through Becky's patches does support the 
>> MPC8641D/e600 cores?
> 
> Yes, its the only part that has XAEN.

Okay I saw a lot of e500/BookE support go past but nothing 
specific :)

>> NOT supported because of the way the LAWs work, and also the alignment 
>> of the LAWs means it is not fine enough granularity to map between 2GB 
>> and 4GB into a window (you can have 2GB or 4GB but not some more 
>> arbitrary value?)
> 
> You can overlap LAWs because they have priority encoding.  The lower the 
> LAW # the higher the priority.

Hmm :)

> Your bigger issue is if you can setup the DDR controller for the hole 
> you want.

Hmmmmm :)

Okay good to know. I'll go back to reading the docs.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

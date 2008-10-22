Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0C39DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 01:58:50 +1100 (EST)
Message-Id: <EF781CC4-B321-4E6A-A376-ADDDC1BB2E7B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48FF3685.5020504@genesi-usa.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Extended Addressing Mode
Date: Wed, 22 Oct 2008 09:58:20 -0500
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<48FF2DDE.9060301@genesi-usa.com>
	<DC24FCF5-F410-47AB-8FC0-592EA0906568@kernel.crashing.org>
	<48FF3685.5020504@genesi-usa.com>
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


On Oct 22, 2008, at 9:19 AM, Matt Sealey wrote:

>
>
> Kumar Gala wrote:
>> On Oct 22, 2008, at 8:42 AM, Matt Sealey wrote:
>>> So to confirm, XAEN support through Becky's patches does support  
>>> the MPC8641D/e600 cores?
>> Yes, its the only part that has XAEN.
>
> Okay I saw a lot of e500/BookE support go past but nothing specific :)

The "XAEN" is specific to e600.  e500 has its own ability to do 36-bit  
physical (not called XAEN).

- k

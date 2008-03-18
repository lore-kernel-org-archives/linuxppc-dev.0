Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77235DDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 19:30:41 +1100 (EST)
Message-ID: <47DF7D6F.8010808@semihalf.com>
Date: Tue, 18 Mar 2008 09:29:35 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>	
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
In-Reply-To: <fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, rpurdie@rpsys.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Mon, Mar 17, 2008 at 4:28 PM, Wolfgang Denk <wd@denx.de> wrote:
[...]
>>  It may be argued that this code should be moved somewhere else, but I
>>  don't remeber to have seen any such review comments.
> 
> The LED code just hasn't been picked up.  IIRC, it was reworked to
> make it a proper driver in drivers/leds. 

Grant,

Yes, the Motion-PRO LED driver has been reworked and posted:
http://patchwork.ozlabs.org/linuxppc/patch?q=Motion-pro&id=16617


 > I need to look at it again,
> but it is a lot of code for a very simple thing and I wasn't sure if I
> should be the one to pick it up because it is in drivers/leds which
> has a different maintainer.

I'm copying Richard Purdie who's listed as LED SUBSYSTEM maintainer.

Richard -- could pick up the above mentioned Motion-PRO LED driver for
upstream inclusion? It started as a MPC5200-specific thing posted to
linuxppc-dev and got reviewed there, with the intent to go upstream via
Grant (MPC52XX maintainer). However, it seems that it should be merged
through your subsystem.

Thanks,
Bartlomiej

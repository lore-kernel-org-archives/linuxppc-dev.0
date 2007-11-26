Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93DF2DDE0C
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 08:40:58 +1100 (EST)
Message-ID: <474B3D7F.8060503@freescale.com>
Date: Mon, 26 Nov 2007 15:41:19 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Move CPM command handling into the cpm
	drivers
References: <4745BB5F.6060002@scram.de>	<fa686aa40711221036n6438c252lde71cffdaff97ea9@mail.gmail.com>	<20071123005121.4d38d877@kernel.crashing.org>	<20071126162446.GA4408@loki.buserror.net>
	<20071127002249.612f4ff6@kernel.crashing.org>
In-Reply-To: <20071127002249.612f4ff6@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> perhaps I was not clear enough. That was a rough idea how to handle
> the whole thing, not just cpm_cr_cmd. This cpm command is a corner
> case, but there can be other actions that may confuse CPM being
> triggered simultaneously or overlapping.

What kind of actions did you have in mind?  Microcode patching?

-Scott

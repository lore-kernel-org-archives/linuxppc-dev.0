Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FDBFDDDE4
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 19:08:41 +1100 (EST)
Date: Tue, 27 Nov 2007 11:08:08 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC/PATCH] powerpc: Move CPM command handling into the cpm
	drivers
Message-ID: <20071127110808.6ef34d92@kernel.crashing.org>
In-Reply-To: <474B3D7F.8060503@freescale.com>
References: <4745BB5F.6060002@scram.de>
	<fa686aa40711221036n6438c252lde71cffdaff97ea9@mail.gmail.com>
	<20071123005121.4d38d877@kernel.crashing.org>
	<20071126162446.GA4408@loki.buserror.net>
	<20071127002249.612f4ff6@kernel.crashing.org>
	<474B3D7F.8060503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 26 Nov 2007 15:41:19 -0600
Scott Wood wrote:

> Vitaly Bordug wrote:
> > perhaps I was not clear enough. That was a rough idea how to handle
> > the whole thing, not just cpm_cr_cmd. This cpm command is a corner
> > case, but there can be other actions that may confuse CPM being
> > triggered simultaneously or overlapping.
> 
> What kind of actions did you have in mind?  Microcode patching?
> 
microcode is another case to handle gracefully. There are also
"soft" cases like cpmux mess-up, incompatible SoC devices (which we are handling by
logical exclude now but which do have natural reasons of "not leaving together" like
shared dedicated GPIO or smth else) etc. 

-- 
Sincerely, Vitaly

Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A1D1DDF22
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 10:47:16 +1000 (EST)
Message-ID: <4851C378.9000506@freescale.com>
Date: Thu, 12 Jun 2008 19:46:48 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Jon Loeliger <jdl@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
	jdl@jdl.com
Subject: Re: dtc: Add support for binary includes.
References: <20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
	<483C4C04.9020408@freescale.com>
	<20080528235859.GA10260@yookeroo.seuss>
	<20080529000227.GB10260@yookeroo.seuss>
	<48404D83.4070108@freescale.com>
	<20080604041304.GD29085@yookeroo.seuss>
	<4846A60F.9020909@freescale.com>
	<20080611015839.GB22012@yookeroo.seuss>
	<20080612164322.GA2972@loki.buserror.net>
	<20080613000125.GA10981@yookeroo.seuss>
In-Reply-To: <20080613000125.GA10981@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

>> It'd be nice if we could keep the filename around for reporting here...
> 
> It would.  Well, I've been intending to clean up the input file
> handling in several ways already, I'll see if that can be worked in.
> 


With Scott's ACK on this, I intend commit David's patch.
So if you adjust the input file reporting here, please
do it as an "additional patch."

And for the record, I will also make an official tagged
release just after any such cleanup patch appears, or
in the next couple days, whichever comes first.

Thanks,
jdl

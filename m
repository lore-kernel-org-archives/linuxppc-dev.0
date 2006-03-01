Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D74F679F4
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 10:10:06 +1100 (EST)
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060301223034.GA5965@suse.de>
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
	<20060226173908.GA4871@suse.de>  <20060301223034.GA5965@suse.de>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 10:09:55 +1100
Message-Id: <1141254596.3889.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > This (sort of) breaks PowerMac3,4 (69 (PowerMac G4 Silver)). I have to
> > force it on up to now, but with this patch the internal speaker will not
> > work with or without my patch to force it on.
> 
> But the patch fixes also my PowerBook4,1, I dont have to toggle the headphone
> once to get the built-in speakers enabled.
> Looks like 2.6.16 stuff, but its been broken for so long now...

What is the status of Ben's latest stuff ?

Ben.

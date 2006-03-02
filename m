Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B1E267B42
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 11:04:44 +1100 (EST)
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060302000019.GB6792@suse.de>
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
	<20060226173908.GA4871@suse.de> <20060301223034.GA5965@suse.de>
	<1141254596.3889.26.camel@localhost.localdomain>
	<1141256965.4378.145.camel@grayson>  <20060302000019.GB6792@suse.de>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 11:04:32 +1100
Message-Id: <1141257873.3889.34.camel@localhost.localdomain>
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

On Thu, 2006-03-02 at 01:00 +0100, Olaf Hering wrote:
>  On Wed, Mar 01, Ben Collins wrote:
> 
> > I'm rediffing now. However, I may not include my tumbler changes
> > immediately. For some reason, those are the ones causing problems. I
> > need to review the diff and see if I can find the problem (which I
> > cannot reproduce).
> 
> Can you make individual patches, each one fixing one thing, going from A
> to B.  You know that hch song...

In that case, it's difficult as it's more like a rewrite of the GPIO
handling from scratch (well... almost)

Ben.

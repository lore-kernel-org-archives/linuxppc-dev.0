Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DD5167B43
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 11:00:24 +1100 (EST)
Date: Thu, 2 Mar 2006 01:00:19 +0100
From: Olaf Hering <olh@suse.de>
To: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Message-ID: <20060302000019.GB6792@suse.de>
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
	<20060226173908.GA4871@suse.de> <20060301223034.GA5965@suse.de>
	<1141254596.3889.26.camel@localhost.localdomain>
	<1141256965.4378.145.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1141256965.4378.145.camel@grayson>
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

 On Wed, Mar 01, Ben Collins wrote:

> I'm rediffing now. However, I may not include my tumbler changes
> immediately. For some reason, those are the ones causing problems. I
> need to review the diff and see if I can find the problem (which I
> cannot reproduce).

Can you make individual patches, each one fixing one thing, going from A
to B.  You know that hch song...

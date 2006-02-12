Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 620C5679EB
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2006 10:28:42 +1100 (EST)
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <1139784411.25288.11.camel@grayson>
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
	<1139784411.25288.11.camel@grayson>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 10:27:29 +1100
Message-Id: <1139786849.27829.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-02-12 at 17:46 -0500, Ben Collins wrote:
> On Mon, 2006-02-13 at 09:35 +1100, Benjamin Herrenschmidt wrote:
> > Can you sync with the patches Ben Collins is doing on this as well ?
> > 
> > Ben, what is your status ? Are you feeding those through upstream the
> > alsa folks ? Or waiting for me to do something ? :)
> > 
> > The above, if it appear to works well enough might be worth merging
> > now ...
> 
> I haven't synced because I've been waiting for some kind of go ahead
> from you. I can rediff against 2.6.16-git and send them to alsa, CC ppc
> list.

Please, do so !

Thanks,
Ben.

Return-Path: <bcollins@ubuntu.com>
Received: from a34-mta02.direcway.com (a34-mta02.direcpc.com [66.82.4.91])
	by ozlabs.org (Postfix) with ESMTP id CBC75679E1
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2006 09:47:16 +1100 (EST)
Received: from mail.phunnypharm.org
	(dpc67142247022.direcpc.com [67.142.247.22]) by a34-mta02.direcway.com
	(iPlanet Messaging Server 5.2 HotFix 1.25 (built Mar  3 2004))
	with ESMTP id <0IUL00FIXJAKIS@a34-mta02.direcway.com> for
	linuxppc-dev@ozlabs.org; Sun, 12 Feb 2006 17:47:13 -0500 (EST)
Date: Sun, 12 Feb 2006 17:46:50 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
In-reply-to: <1139783738.5247.54.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-id: <1139784411.25288.11.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
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

On Mon, 2006-02-13 at 09:35 +1100, Benjamin Herrenschmidt wrote:
> Can you sync with the patches Ben Collins is doing on this as well ?
> 
> Ben, what is your status ? Are you feeding those through upstream the
> alsa folks ? Or waiting for me to do something ? :)
> 
> The above, if it appear to works well enough might be worth merging
> now ...

I haven't synced because I've been waiting for some kind of go ahead
from you. I can rediff against 2.6.16-git and send them to alsa, CC ppc
list.

-- 
Ben Collins
Kernel Developer - Ubuntu Linux

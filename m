Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0306FDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 00:38:59 +1000 (EST)
Date: Tue, 27 May 2008 18:38:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/7] Patches for Kumar's powerpc-next tree
Message-ID: <20080527143857.GA3041@polina.dev.rtsoft.ru>
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080523163811.GA12181@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 08:38:11PM +0400, Anton Vorontsov wrote:
> Hi Kumar,
> 
> Here is updated series, with your comments addressed. Patches are
> rebased on top of your current powerpc-next branch.

Are there any issues with this series? If not, Kumar, could you please
apply this except this patch:

> [PATCH 6/7] [POWERPC] booting-without-of: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs bindings

It'll need more discussion, obviously.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net [5.9.151.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3q8f3CpyzDt31
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 23:29:38 +1100 (AEDT)
Message-ID: <1477484939.4059.35.camel@sipsolutions.net>
Subject: Re: [PATCH 11/13] ALSA: Deletion of checks before the function call
 "iounmap"
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Carpenter <dan.carpenter@oracle.com>, SF Markus Elfring
 <elfring@users.sourceforge.net>
Cc: Jaroslav Kysela <perex@perex.cz>, Clemens Ladisch <clemens@ladisch.de>,
 Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>,
 Thibaut Varene <T-Bone@parisc-linux.org>,  alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org,  linux-parisc@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>,  kernel-janitors@vger.kernel.org, Julia
 Lawall <julia.lawall@lip6.fr>
Date: Wed, 26 Oct 2016 14:28:59 +0200
In-Reply-To: <20161026122605.GA3911@mwanda>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54A9355F.4050102@users.sourceforge.net>
 <54A941C1.4020906@users.sourceforge.net> <20161026122605.GA3911@mwanda>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-26 at 15:26 +0300, Dan Carpenter wrote:
> Someone was just mentioning in another thread that removing the check
> from iounmap() is not portable to other arches and then I remembered
> that Markus removed a bunch of these.
> 
> We should consider reverting this, perhaps?

Can't we teach all architectures? Not that reverting it would be a
problem.

johannes

Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3qSX73BjzDt3P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 23:43:24 +1100 (AEDT)
Date: Wed, 26 Oct 2016 15:42:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 Jaroslav Kysela <perex@perex.cz>, Clemens Ladisch <clemens@ladisch.de>,
 Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>,
 Thibaut Varene <T-Bone@parisc-linux.org>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 11/13] ALSA: Deletion of checks before the function call
 "iounmap"
Message-ID: <20161026124245.GR4418@mwanda>
References: <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54A9355F.4050102@users.sourceforge.net>
 <54A941C1.4020906@users.sourceforge.net>
 <20161026122605.GA3911@mwanda>
 <1477484939.4059.35.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477484939.4059.35.camel@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 26, 2016 at 02:28:59PM +0200, Johannes Berg wrote:
> On Wed, 2016-10-26 at 15:26 +0300, Dan Carpenter wrote:
> > Someone was just mentioning in another thread that removing the check
> > from iounmap() is not portable to other arches and then I remembered
> > that Markus removed a bunch of these.
> > 
> > We should consider reverting this, perhaps?
> 
> Can't we teach all architectures? Not that reverting it would be a
> problem.

We probably should.  I just didn't want to suggest it, in case it sounds
like volunteering...  I'm not going to be able to do it because I'm on
the road for a bit.

regards,
dan carpenter

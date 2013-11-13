Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net [144.76.43.152])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 450D12C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 20:08:10 +1100 (EST)
Message-ID: <1384331394.14578.0.camel@jlt4.sipsolutions.net>
Subject: Re: [patch] ALSA: snd-aoa: two copy and paste bugs
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
Date: Wed, 13 Nov 2013 09:29:54 +0100
In-Reply-To: <s5h4n7gso19.wl%tiwai@suse.de>
References: <20131113074520.GD25541@elgon.mountain>
 <s5h4n7gso19.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org,
 Dan Carpenter <dan.carpenter@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-13 at 09:29 +0100, Takashi Iwai wrote:
> At Wed, 13 Nov 2013 10:45:20 +0300,
> Dan Carpenter wrote:
> > 
> > These functions were cut and paste and the tests for NULL weren't
> > updated properly.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks, applied.

FWIW, looks fine to me - I wonder how long this has been broken though,
must be practically forever. I guess we never got it wrong and missed
adding some pointers? :-)

johannes

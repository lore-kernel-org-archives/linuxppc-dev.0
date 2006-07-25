Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5671967B32
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 07:53:33 +1000 (EST)
Subject: Re: [Alsa-devel] [PATCH 0/5] powerpc sound, some more patches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <7015.131.234.232.48.1153840399.squirrel@secure.sipsolutions.net>
References: <20060718172841.046446000@sipsolutions.net>
	<s5hy7uhsra7.wl%tiwai@suse.de>
	<7015.131.234.232.48.1153840399.squirrel@secure.sipsolutions.net>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 16:52:14 -0500
Message-Id: <1153864334.18353.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-07-25 at 17:13 +0200, Johannes Berg wrote:
> Takashi Iwai wrote:
> 
> > Thanks, now all patches are on ALSA tree.
> 
> Thanks.
> These should still go into 2.6.18, will that be possible?

They should still, for sure. Johannes, please sync with Paulus since I
think you posted previous version of at least some of these that he's
about to push to Linus via the powerpc tree.

Ben.

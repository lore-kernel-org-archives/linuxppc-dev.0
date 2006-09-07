Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC70F67BC4
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 23:01:36 +1000 (EST)
Subject: Re: [Alsa-devel] oops in snd-powermac due to snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h64fzltyg.wl%tiwai@suse.de>
References: <20060907124256.GA22928@aepfle.de> <s5h64fzltyg.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 15:02:04 +0200
Message-Id: <1157634124.2857.67.camel@ux156>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 14:52 +0200, Takashi Iwai wrote:

> Does the patch below work?

If it does help, isn't this again the issue with snd-powermac abusing
the i2c layer?

johannes

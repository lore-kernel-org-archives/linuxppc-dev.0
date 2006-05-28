Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B17967A64
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 05:02:48 +1000 (EST)
Message-Id: <20060528190026.754474000@johannes.berg>
Date: Sun, 28 May 2006 21:00:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: alsa-devel@alsa-project.org
Subject: [RFC 0/7] snd-aoa: add snd-aoa
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches would add snd-aoa to the Linux source tree. I'm
posting them here in the spirit of getting review fairly early, it works
fine for those machines it handles but has some rough edges like not
providing headphone detection at the moment.

There are plans to fix this, but they might be influenced by your comments
so I'm holding off there a bit. One thing that will probably be done is
moving all the alsa controls for various inputs from the codecs to the
fabric, the fabric needs to know these anyway and code can be simplified and
prepared for headphone/... detection if the codecs simply provide hooks to
turn on/off the various in- and outputs.

Any comments are appreciated.

Thanks,
johannes

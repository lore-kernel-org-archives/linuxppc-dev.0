Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E49867B89
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 04:43:28 +1000 (EST)
Message-Id: <20060718172841.046446000@sipsolutions.net>>
Date: Tue, 18 Jul 2006 19:28:41 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] powerpc sound, some more patches
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a new and hopefully final round of patches fixing problems with my
new snd-aoa driver. There are fixes for the PPC Mac Mini as well as for a
problem with snd-powermac that I had noticed.

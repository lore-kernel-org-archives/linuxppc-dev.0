Return-Path: <perex@suse.cz>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by ozlabs.org (Postfix) with ESMTP id 4E9A0679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 22:49:36 +1000 (EST)
Date: Tue, 16 May 2006 14:31:00 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
In-Reply-To: <1147780945.29795.110.camel@johannes>
Message-ID: <Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
References: <1147780945.29795.110.camel@johannes>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ALSA development <alsa-devel@alsa-project.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 16 May 2006, Johannes Berg wrote:

> Apparently all alsa userspace programs including alsamixer suck. Hence,
> this patch is required to make them work properly. Why is it so hard to
> do these additions/subtractions in the program or maybe even in the alsa
> library? The alsa libraries already think they know better and mess up
> all kinds of things.

It's better to fix apps, if they are broken.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id 68419679F2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 08:04:42 +1000 (EST)
Subject: Re: [Alsa-devel] Re: [RFC] alsa integer control ranges
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1147816857.6753.1.camel@localhost.localdomain>
References: <1147780945.29795.110.camel@johannes>
	<1147816857.6753.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 16 May 2006 18:04:39 -0400
Message-Id: <1147817080.13948.160.camel@mindpipe>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 08:00 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2006-05-16 at 14:02 +0200, Johannes Berg wrote:
> > Apparently all alsa userspace programs including alsamixer suck. Hence,
> > this patch is required to make them work properly. Why is it so hard to
> > do these additions/subtractions in the program or maybe even in the alsa
> > library? The alsa libraries already think they know better and mess up
> > all kinds of things.
> 
> alsamixer works for me with negative ranges... but all other apps don't
> and there are various bugs, I blame apps converted from OSS....

kmix is the worst by far, someone really needs to fix it.  It has so
many bugs that it's unusable for debugging ALSA, we have to tell people
to use alsamixer.

Lee

Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id 122F9679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 00:59:51 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Lee Revell <rlrevell@joe-job.com>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1147780945.29795.110.camel@johannes>
References: <1147780945.29795.110.camel@johannes>
Content-Type: text/plain
Date: Tue, 16 May 2006 10:53:05 -0400
Message-Id: <1147791186.13948.109.camel@mindpipe>
Mime-Version: 1.0
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

On Tue, 2006-05-16 at 14:02 +0200, Johannes Berg wrote:
> Apparently all alsa userspace programs including alsamixer suck. Hence,
> this patch is required to make them work properly. Why is it so hard to
> do these additions/subtractions in the program or maybe even in the alsa
> library? The alsa libraries already think they know better and mess up
> all kinds of things.
> 
> What are your opinions on this? Should this be required? And if so, why
> do we even have the value.integer.min when we can't use it anyway? 
> 
> The code this patch applies against is in
> http://johannes.sipsolutions.net/snd-aoa.git/ but that isn't all too
> relevant, the patch serves just as an illustration of what is wrong
> here.
> 

Ummm... what problem is this patch fixing?

Lee

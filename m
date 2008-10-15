Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id B0A53DDDD4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 01:34:22 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2717934rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 07:34:21 -0700 (PDT)
Date: Wed, 15 Oct 2008 08:34:19 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Please pull 'next' branch of
	git://git.secretlab.ca/git/linux-2.6-mpc52xx
Message-ID: <20081015143419.GH16262@secretlab.ca>
References: <fa686aa40810090102wcc8acf0i4577f195ca40eac6@mail.gmail.com>
	<20081014133346.GE23594@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081014133346.GE23594@pengutronix.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2008 at 03:33:46PM +0200, Wolfram Sang wrote:
> What about these? :)
> 
> http://oldpatchwork.ozlabs.org/linuxppc-embedded/patch?id=20188
> (remove obsolete code from mpc52xx_phy)

I'm not going to pick this one up yet (as mentioned in my earlier
email)

> http://oldpatchwork.ozlabs.org/linuxppc-embedded/patch?id=20189
> (simplify read/write in mpc52xx_phy)
> http://oldpatchwork.ozlabs.org/linuxppc-embedded/patch?id=20202
> (don't touch pipelining)

Both of these are in my tree and I'll be asking Ben to pull soon.

> And to which tree did this one go? I couldn't find it on
> git.secretlab.ca.

In the 'next' branch of my mpc52xx tree.

g.

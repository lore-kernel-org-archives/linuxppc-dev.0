Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 6D417B6EEA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 09:21:20 +1100 (EST)
Date: Thu, 24 Dec 2009 01:21:16 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: ucc_geth broken in 2.6.32 by
	864fdf884e82bacbe8ca5e93bd43393a61d2e2b4
Message-ID: <20091223222116.GA851@oksana.dev.rtsoft.ru>
References: <20091223174019.GB762@caffeine.csclub.uwaterloo.ca>
	<20091223180415.GA12987@oksana.dev.rtsoft.ru>
	<20091223200948.GF760@caffeine.csclub.uwaterloo.ca>
	<20091223202226.GA8185@oksana.dev.rtsoft.ru>
	<20091223221047.GH760@caffeine.csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091223221047.GH760@caffeine.csclub.uwaterloo.ca>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 23, 2009 at 05:10:47PM -0500, Lennart Sorensen wrote:
[...]
> That seems to be it.  It works now.  No more crashes.
> Those two patches together seem to do the trick.

Great!

> I really hope they
> can go into 2.6.32-stable then, since this is a regression over 2.6.31
> and is hopefully an obvious fix.

Yep, will try to get them there.

Thanks a lot for helping to track this down,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

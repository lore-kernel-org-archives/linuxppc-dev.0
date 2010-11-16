Return-Path: <cbouatmailru@gmail.com>
Date: Wed, 17 Nov 2010 01:03:31 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] powerpc: pcm030/032: add pagesize to dts
Message-ID: <20101116220331.GA29681@oksana.dev.rtsoft.ru>
References: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
	<1289841916-3825-2-git-send-email-w.sang@pengutronix.de>
	<20101115173250.GA22104@oksana.dev.rtsoft.ru>
	<4CE1A0E4.5030505@firmworks.com>
	<20101115212432.GA17754@oksana.dev.rtsoft.ru>
	<20101115221156.GA25167@pengutronix.de>
	<20101116214537.GD19893@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20101116214537.GD19893@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 16, 2010 at 10:45:37PM +0100, Wolfram Sang wrote:
> 
> > Even worse, I seem to recall that I had once seen a manufacturer increasing the
> > page-size from one charge to the next without changing the part-number, so I
> > got this feeling "you can't map pagesize to manufacturer/type" which I still
> > have. Sadly, this was long ago, so I can't proof it right now. Will try to dig
> > up some datasheets when in the office tomorrow.
> 
> Had a look, couldn't find anything :( And now?

Well, it seems that there are enough people in "pagesize" camp
anyway, I'd say just go ahead with the current approach. :-)

It's an additional information, so won't do any harm anyway...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

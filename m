Return-Path: <josh@joshtriplett.org>
Received: from relay2-v.mail.gandi.net (relay2-v.mail.gandi.net
	[217.70.178.76]) by ozlabs.org (Postfix) with ESMTP id BC6F9B7C59
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Mar 2010 09:24:50 +1100 (EST)
Date: Sun, 28 Mar 2010 15:24:42 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: Failing to get DMA working with MPC5200 (TQM5200) and CompactFlash
Message-ID: <20100328222441.GC16396@feather>
References: <20100317051521.GA16826@feather>
	<fa686aa41003261122s7c03244bm2ffc3347263af613@mail.gmail.com>
	<20100326213202.GD5350@feather>
	<20100326221707.GA1953@leila.ping.de>
	<20100326225916.GA5690@feather> <1269696136.2245.1@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1269696136.2245.1@antares>
Cc: Wolfgang Wegner <wolfgang@leila.ping.de>, linuxppc-dev@lists.ozlabs.org,
	Andrew Greenberg <andrew@psas.pdx.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 27, 2010 at 02:22:08PM +0100, Albrecht Dreß wrote:
> Am 26.03.10 23:59 schrieb(en) Josh Triplett:
> [snip]
> >Any other ideas for things we could check to try to track down this problem?
> 
> Might your issue be related to this thread: <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/078757.html>?

We have the MPC5200C rev of the board, not the MPC5200B rev which
apparently had many problems like the ones described in that thread.  I
can't rule out other crazy board errata we don't know about, though. :)

- Josh Triplett

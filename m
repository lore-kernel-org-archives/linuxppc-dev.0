Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 13CEFDDED7
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 07:49:30 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH v3 0/4 REPOST] OF infrastructure for SPI devices
Date: Sun, 27 Jul 2008 14:49:28 -0700
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
In-Reply-To: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807271449.28472.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 25 July 2008, Grant Likely wrote:
> I don't know what to do with these patches.  I'd really like to see them
> in .27, and now that akpm has cleared his queue, the prerequisite patch
> has been merged so they are ready to go in.  However, even though there
> has been favourable reception on the SPI and linuxppc lists for these
> changes I don't have any acks from anybody yet.
> 
> David, can you please reply on if you are okay with these patches
> getting merged?  If so, do you want me to merge them via my tree, or
> do you want to pick them up?

OK ... to recap, #1 and #3 are OF-specific, I'll be agnostic.
If other OF folk think it's OK, great.

Some cleanup was needed for #2, but it was basically ok ...
I'd like to see the final version, and if it goes via an
OF push that's OK by me.  (Though I'd like to see that change
make it into 2.6.27 regardless, so let me know.)

And #4 isn't quite cooked yet.

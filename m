MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14797.11370.609130.657303@ipa.ne.mediaone.net>
Date: Sat, 23 Sep 2000 18:19:22 -0400
From: R Shapiro <reshapiro@mediaone.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Michel Ddnzer <daenzerm@student.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <Pine.LNX.4.10.10009231802380.1165-100000@opal.biophys.uni-duesseldorf.de>
References: <14796.52485.753924.552345@ipa.ne.mediaone.net>
	<Pine.LNX.4.10.10009231802380.1165-100000@opal.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > That might be due to a bug in the ati driver (last time I rsynced in
 > mid-July, there was a bug in Mach64PPCPreInit:
 > [...]
 > 	/* hack */
 > 	pScrn->videoRam = 2048;
 > [...]
 > The hack to unconditionally set pScrn->videoRam to 2M should be removed,


The rsync of atimach64ppc.c I got earlier today doesn't have this
unconditonal assignment hack anymore.  The hardwired vram setting
certainly could have caused at least some of the problems I was
running into on Friday.  I'll try this new ati driver first thing
Monday and report back.



--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

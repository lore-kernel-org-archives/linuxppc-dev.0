Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id 6826FB70BD
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 02:52:54 +1000 (EST)
Date: Tue, 27 Jul 2010 18:52:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
	of_node_to_nid()
Message-ID: <20100727165250.GB26649@merkur.ravnborg.org>
References: <20100726220405.1550.63442.stgit@angua>
	<20100726222627.GA23501@merkur.ravnborg.org>
	<AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
	<201007271534.01250.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201007271534.01250.arnd@arndb.de>
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 27, 2010 at 03:34:01PM +0200, Arnd Bergmann wrote:
> On Tuesday 27 July 2010, Grant Likely wrote:
> > > I suggest to go back to v2 of your patch where you use asm-generic/of.h.
> > 
> > Stephen suggested dropping asm-generic/of.h.  I'm happy to do it either way.
> 
> I don't mind adding stuff to asm-generic, but I think in this case it would
> be easier to keep this in linux/of.h because there is nothing wrong with
> all architectures including it.
> 
> Most files in asm-generic are there only for historical reasons, where some
> architectures use them but others don't. IMHO we should use the include/linux
> headers preferred for new stuff though.

Hi Arnd.

Thanks for this explanation. Obviously my previous post
about asm-generic was wrong (as Grant already indicated).

	Sam

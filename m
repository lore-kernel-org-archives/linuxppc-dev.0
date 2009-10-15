Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45733B70B3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 16:37:24 +1100 (EST)
In-Reply-To: <20091015010855.GA32710@compile2.chatsunix.int.mrv.com>
References: <20091015004127.GA15570@laura.chatsunix.int.mrv.com>
	<1255568772.2347.60.camel@pasglop>
	<20091015010855.GA32710@compile2.chatsunix.int.mrv.com>
Subject: Re: I think I have 8xx working...
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OFF8DE0AF1.D312CF3B-ONC1257650.001E5428-C1257650.001E7036@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 15 Oct 2009 07:32:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rex Feany <RFeany@mrv.com> wrote on 15/10/2009 03:08:55:
>
> Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):
>
> > On Wed, 2009-10-14 at 17:41 -0700, Rex Feany wrote:
> > > The biggest problem for me turned out to be the MMU context IDs being
> > > clamped to 32 when the 8xx only has 16. With this, things are a bit more
> > > stable :)
> >
> > This is with Joakim patches or without ?
>
> with just one: adding tlbil_va() to do_page_fault().

Looking forward too hear about the the other patches too :)

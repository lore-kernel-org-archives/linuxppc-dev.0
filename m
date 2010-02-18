Return-Path: <pl@ninthfloor.org>
Received: from mail.ninthfloor.org (ninthfloor.org [109.74.194.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "nabla.ninthfloor.org",
	Issuer "nabla.ninthfloor.org" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3D594B7D05
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Feb 2010 02:34:48 +1100 (EST)
Date: Thu, 18 Feb 2010 15:34:42 +0000
From: Paride Legovini <pl@ninthfloor.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: resurrecting the mvme5100 ppc platform
Message-ID: <20100218153442.GC2873@ninthfloor.org>
References: <20100204133935.GA9337@ninthfloor.org>
	<20100208112116.GA3381@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100208112116.GA3381@iram.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2010 at 12:21:16PM +0100, Gabriel Paubert wrote:
> On Thu, Feb 04, 2010 at 01:39:35PM +0000, Paride Legovini wrote:
> > Hello,
> > I'm just started working on some mvme5100 boards, and so I discovered
> > that support for these cards has been dropped with linux-2.6.27 due to
> > lack of interest. Here is the relevent post on linuxppc-embedded:
> > 
> > http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg30049.html
> > 
> > Well, I'd really like to see support for the mvme5100 to be reintegrated
> > in the kernel. I'm willing to help on this, but at the moment I don't
> > know how much work is to be done, as I don't know how the switch from
> > ppc to powerpc changed things.
> 
> A lot, these are PreP platforms. I'm using several MVME24xx/26xx/27xx
> here (some have been running continously over a decade). They have 
> a lot of similarities with MVME5100 if I remember correctly. 
> 
> I don't have time right now (especially if I am alone) to write 
> support for them, but I am interested in running a more recent
> kernel, provided it's not too bloated (some machines only have
> 16MB of RAM).

This is quite discouraging, I think I'll just keep using linux-2.6.26.8,
the last kernel supporting the mvme5100 (afaik). I'd like to work on
a patch for newer kernels, but I have to finish a project in a
reasonable time, so unfortunately I can't start studying these kernel
internals now. Anyway, if you'll feel like working on it tell me, I'll
be happy to help.

Paride

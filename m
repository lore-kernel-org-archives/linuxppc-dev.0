Return-Path: <SRS0+2989a05f4816f000e041+2015+infradead.org+arjan@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8EE1DDE22
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 04:54:36 +1100 (EST)
Date: Sat, 28 Feb 2009 09:54:33 -0800
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-ID: <20090228095433.6af07a89@infradead.org>
In-Reply-To: <20090228174601.GB27607@kroah.com>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<20090228174601.GB27607@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stable@kernel.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 28 Feb 2009 09:46:01 -0800
Greg KH <greg@kroah.com> wrote:

> On Sat, Feb 28, 2009 at 09:23:36AM -0800, Linus Torvalds wrote:
> > On Fri, 27 Feb 2009, Roland McGrath wrote:
> > > But here is the patch you asked for.
> > 
> > Yes, this looks much more straightforward. 
> > 
> > And I guess the seccomp interaction means that this is potentially
> > a 2.6.29 thing. Not that I know whether anybody actually _uses_
> > seccomp. It does seem to be enabled in at least Fedora kernels, but
> > it might not be used anywhere.
> 
> It's enabled in SuSE kernels.
> 

but are there users of it?
I thought Andrea stopped the cpushare thing that was the only user of
this....


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org

Return-Path: <amodra@bigpond.net.au>
Date: Wed, 9 Mar 2005 22:36:01 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20050309120601.GN15642@bubble.modra.org>
References: <20050309120343.0c22eb0f.sfr@canb.auug.org.au>
	<20050309011929.GI15642@bubble.modra.org>
	<Pine.LNX.4.62.0503091038520.22598@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0503091038520.22598@numbat.sonytel.be>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] combining header files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2005 at 10:40:13AM +0100, Geert Uytterhoeven wrote:
> On Wed, 9 Mar 2005, Alan Modra wrote:
> > On Wed, Mar 09, 2005 at 12:03:43PM +1100, Stephen Rothwell wrote:
> > > I would just like to start a discussion about consolidating (some of) the
> > > ppc and ppc64 header files.
> > 
> > Marvellous!  In case it isn't completely obvious, you can often share
> > structure definitions between ppc32 and ppc64 by judicious selection of
> > types.  eg.
> > 
> > struct stays_the_same {
> >   long long some_64bit_var;
> >   int some_32bit_var;
> > }
> 
> If size matters, why not use an explicitly sized type like s64 to make it
> explicit?

Sure, that's even better.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre

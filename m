Date: Wed, 7 Nov 2001 13:41:25 -0700
From: Val Henson <val@nmt.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The Plan
Message-ID: <20011107134125.O22194@boardwalk>
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com> <Pine.GSO.4.21.0111071246050.11631-100000@mullein.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0111071246050.11631-100000@mullein.sonytel.be>; from geert@linux-m68k.org on Wed, Nov 07, 2001 at 12:47:33PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 07, 2001 at 12:47:33PM +0100, Geert Uytterhoeven wrote:
>
> On Wed, 7 Nov 2001, Paul Mackerras wrote:
> > - Files which relate only to one platform, or a small number of
> >   platforms, move to arch/ppc/platforms.  (There are some minor
> >   exceptions to this rule which we can discuss if people are
> >   concerned.)  We end up with:
>
> Why not move platform-specific files to arch/ppc/<platform>/ instead?
>
> Your solution reduces the clutter only by a factor of 2, while creating
> platform-specific directories reduces it by a factor of n.

I agree with Geert.  I don't think that dividing the clutter into two
directories instead of one really improves matters.  Each directory is
still monstrously huge and the division is non-obvious.
arch/ppc/masochist would be easier to understand. :)

What is the problem we're trying to solve here?

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

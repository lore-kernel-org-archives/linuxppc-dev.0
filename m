Date: Thu, 31 Aug 2000 18:44:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Message-ID: <20000831184447.D3823@opus.bloom.county>
References: <39AE80BD.D86B34DA@embeddededge.com> <Pine.HPX.4.10.10008311808260.15978-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10008311808260.15978-100000@gra-ux1.iram.es>; from paubert@iram.es on Thu, Aug 31, 2000 at 06:10:55PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 31, 2000 at 06:10:55PM +0200, Gabriel Paubert wrote:
>
>
> On Thu, 31 Aug 2000, Dan Malek wrote:
>
> > I would also like to see us spend a little more time trying to
> > stabilize 2.4 instead of trying to solve elaborate configuration and
> > boot schemes.  That is what 2.5 is for.
>
> What are your problems with 2.4 ? I'm at 2.4.0-test7 and I've not had any
> problem so far, although I still need to upgrade my modutils.

Here's a few: The PCI resource allocation/conflict stuff has "issues" with
some Pmacs (7600, Yikes! G4, I don't know about others).  And my powerstack
series e doesn't get beyond loading linux right now (I haven't played too much
tho.)  But regardless, this is a 2.5 issues.  I'd be very supprised if this
gets into 2.4.0 or even an early 2.4.x.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

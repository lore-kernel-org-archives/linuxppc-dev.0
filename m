Date: Fri, 14 Sep 2001 08:26:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Some more 4xx exception fixes
Message-ID: <20010914082635.F3851@zax>
References: <20010912133344.S4823@zax> <3B9F8260.DA1C7EA@mvista.com> <20010913175139.A3851@zax> <3BA11A49.A94ACBE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA11A49.A94ACBE@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 13, 2001 at 04:42:49PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> > Sorry, can you elaborate on that?
>
> No, you are right.  We need to find a way to fix this, but
> I sure don't want yet another test and branch in the TLB handler.

There isn't one - check the patch.  If we test ESPRN_DIZ, we don't
need to check ESPRN_DST because the fault must be a write fault.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

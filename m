Date: Thu, 9 Jan 2003 13:23:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405LP - Beech with SSX firmware
Message-ID: <20030109022326.GB6569@zax.zax>
References: <1040427361.1096.27.camel@granite.austin.ibm.com> <1042053852.1207.176.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1042053852.1207.176.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jan 08, 2003 at 01:23:56PM -0600, Hollis Blanchard wrote:
> On Fri, 2002-12-20 at 17:36, Hollis Blanchard wrote:
> > Hi, this patch (copied from Arctic) allows Beech to boot with SSX
> > firmware. If there's a way to detect OpenBIOS vs PIBS (I've asked for
> > confirmation) then I think the Beech and Arctic ifdefs could be combined
> > in the file. There may not be though, and in the meantime this works.
>
> There is currently no way to detect PIBS, though I think I talked the
> developer into including "PIBS" string in the future.

I've applied the patch to 2_4_devel.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

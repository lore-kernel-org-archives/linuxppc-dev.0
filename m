Date: Tue, 18 Jun 2002 14:40:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: 40x large page PTEs - Mark IV
Message-ID: <20020618044003.GJ5238@zax>
References: <20020614060022.GB1124@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614060022.GB1124@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 04:00:22PM +1000, David Gibson wrote:
>
> This version of the patch fixes a few compilation problems in the last
> version when CONFIG_NOT_COHERENT_CACHE was not set.  I'm running it
> now on my TiBook, and it works nicely on the 405GP machine.

Ok, deathly silence.  Anyone who would object to this patch being
pushed (to 2_4_devel) please raise their hands...

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

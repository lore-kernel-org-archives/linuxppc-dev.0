Date: Wed, 18 Dec 2002 11:59:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405LP EBC setup fix
Message-ID: <20021218005924.GD3666@zax.zax>
References: <1040151079.1100.119.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1040151079.1100.119.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 17, 2002 at 12:51:18PM -0600, Hollis Blanchard wrote:
> EBC0_B0CR should be set as 16-bit; through an ifdef merging typo it is
> currently set incorrectly as 8-bit. This prevents 405LP wakeup from
> succeeding and needs to be fixed.
>
> Please apply to _2_4_devel and 2.5.

I've applied this to _2_4_devel, but not to 2.5 (I'm not really
up-to-date on 2.5 at the moment).

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Thu, 19 Dec 2002 13:51:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405LP compile fix
Message-ID: <20021219025130.GD6865@zax.zax>
References: <1040226565.29647.15.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1040226565.29647.15.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 18, 2002 at 09:49:24AM -0600, Hollis Blanchard wrote:
>
> I'm glad I'm not the only one who sometimes doesn't compile-test his
> patches... ;)
>
> This patch fixes the Beech build, which is calling the now-nonexistant
> function beech_time_init. In actuality beech_calibrate_decr was never called
> anyways... :)

Oops, wasn't paying enough attention to your post.

> Please apply to _2_4_devel.

Applied.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

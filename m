Date: Thu, 13 Jun 2002 17:51:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: get_pteptr()
Message-ID: <20020613075149.GH4228@zax>
References: <20020613040345.GD4228@zax> <3D08276D.3080502@embeddededge.com> <20020613052745.GF4228@zax> <3D0849F5.6080003@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D0849F5.6080003@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 03:29:57AM -0400, Dan Malek wrote:
> David Gibson wrote:
>
> >Do you mean get_pteptr() or iopa()?
>
> In iopa().  Just put an #ifdef in there for 4xx that does addr - KERNELBASE,
> just like virt_to_bus/phys does for other processors (except 8xx).

Well, if we were going to do that then we might as well just pull 4xx
from the list of CONFIGs for which virt_to_bus() calls iopa() in the
first place.  The only other places that iopa() is called are 8xx
specific anyway.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Fri, 14 Jun 2002 10:33:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin <akuster@pacbell.net>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
Message-ID: <20020614003330.GN4228@zax>
References: <20020604035947.GH2762@zax> <3CFCFC20.80101@embeddededge.com> <15614.37065.549142.218906@argo.ozlabs.ibm.com> <3CFEE9A3.5060300@embeddededge.com> <15614.63160.272890.683586@argo.ozlabs.ibm.com> <3CFF1624.2070808@embeddededge.com> <20020612035203.GQ25800@zax> <3D06E702.4000709@embeddededge.com> <20020612064344.GT25800@zax> <3D08E0CD.4040806@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D08E0CD.4040806@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 11:13:33AM -0700, Armin wrote:
>
> David Gibson
> >
> >Heh, so instead we got a half-assed re-implementation (with a whole
> >bunch of extraneous pointless crap) in the form of the OCP layer.
> >
>
> Crap...this pointless crap has made it easier to add driver support to
> new IBM 4xx processors. And the Idea goes beyond PPC :)  Cosmetic
> changes don't help make things not half-assed and mature.  Flushing the
> idea, API's and usage does.

No actually.  It's become easier to add driver support to new IBM 4xx
processors because of the several sensible and useful ideas that have
gone in along with all the extraneous pointless crap.  All my ocp
patches have had the aim of leaving the former intact while
(gradually) removing the latter.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

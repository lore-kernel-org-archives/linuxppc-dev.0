From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15626.55930.673731.803194@argo.ozlabs.ibm.com>
Date: Sat, 15 Jun 2002 16:11:06 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
In-Reply-To: <3D0A1D53.6040205@embeddededge.com>
References: <20020614042928.GK26146@zax>
	<20020614153954.GL13541@opus.bloom.county>
	<3D0A1D53.6040205@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> The newer ARM version only allocates the number of pages necessary to
> cover the request.  The old version, and the one in PowerPC right now,
> would just use __get_free_pages, which was a power-of-two allocator.

Interesting.  Using __get_free_pages guarantees that the pages are
physically contiguous.  Does the new ARM version do something clever
to get physically contiguous pages?  Or do the callers have to do a
scatter/gather type of operation if they are using more than 1 page?

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

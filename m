Message-ID: <3D0A6161.2080804@embeddededge.com>
Date: Fri, 14 Jun 2002 17:34:25 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
References: <20020614042928.GK26146@zax> <20020614153954.GL13541@opus.bloom.county> <3D0A1D53.6040205@embeddededge.com> <20020614171035.GM13541@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> I'm not sure either.  __iounmap on ARM just is vfree() with the casts.

The issue is in consistent_free() they forcibly reset the Reserved
indicator on the pages.  I don't know why this is necessary.  It's
either due to the way they remap the pages during the allocation or
some change in the Linux VM that I haven't yet discovered :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15614.37065.549142.218906@argo.ozlabs.ibm.com>
Date: Thu, 6 Jun 2002 08:29:29 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
In-Reply-To: <3CFCFC20.80101@embeddededge.com>
References: <20020531042153.GD16537@zax>
	<3CFC0D3F.9030901@embeddededge.com>
	<20020604035947.GH2762@zax>
	<3CFCFC20.80101@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> If you would allow these to stay, you wouldn't have to change any other
> mapping functions, like iopa().  It's only a couple of pages.......

Dan, you continue to surprise me.  You complain about a kB or two for
a device tree but happily throw away anything from 16kB to 128kB or
more just to simplify iopa, which should not be needed anyway.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

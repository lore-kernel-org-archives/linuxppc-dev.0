From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Pantelis Antoniou" <panto@intracom.gr>,
	<acurtis@directvinternet.com>
Cc: <joakim.tjernlund@lumentis.se>,
	"Tom Rini" <trini@kernel.crashing.org>,
	"Dan Malek" <dan@embeddededge.com>,
	"Paul Mackerras" <paulus@au1.ibm.com>,
	"Matt Porter" <porter@cox.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Regarding consistent_alloc
Date: Wed, 11 Dec 2002 07:36:01 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFOEPGDPAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <3DF75343.3060005@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Lets assume that we force the memory returned by the xxx_cpm_hostalloc()
> and xxx_cpm_dpalloc() routines to return contiguous memory both
> virtually and physically. Is there any negative impact?
> Every driver out there expects precisely that.
>

It will be interesting to see how you solve the virtual and physical
contiguity in a general implementation. IMHO it isn't worth the effort.

> Regarding the dual-ported memory, keep in mind that there are members
> of the 8xx family that are very constrained.
> Better allocation routines will allow us to utilise even the gaps
> left between configured parameter areas. Yes it is horrible
> but that's the way that the hardware is designed.

Yes, we need every spare byte and sometime you MUST use certain memory
regions based on hardware contraints.

Sorry for any confusion.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

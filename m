Subject: RE: 601 BAT sizes
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <NCBBIINEHIPFGJPLBEIFIEFCDLAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFIEFCDLAA.acurtis@onz.com>
Content-Type: text/plain
Date: 28 Aug 2002 10:05:49 -0500
Message-Id: <1030547150.1373.171.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2002-08-28 at 09:35, Allen Curtis wrote:
>
> > I don't believe this is correct for all PowerPC processors that have BATs.
> > Can you verify this and ensure it works on everything?  I know 601s have
> > different sized BATs, and the caller of this function really needs to know
> > what they are doing to ensure this works correctly.
>
> It is correct according to the comments for setbat(), I will double check.

601 BATs only do 128KiB to 8 MiB. In fact setbat special-cases 601 and
limits it to 8MiB. I believe updating the setbat comment would be a good
idea...

-Hollis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

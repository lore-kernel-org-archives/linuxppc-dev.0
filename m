Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Misc 8260 fixes/options
Date: Wed, 28 Aug 2002 07:35:28 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFIEFCDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3D6C63B6.8050508@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I don't believe this is correct for all PowerPC processors that have BATs.
> Can you verify this and ensure it works on everything?  I know 601s have
> different sized BATs, and the caller of this function really needs to know
> what they are doing to ensure this works correctly.

It is correct according to the comments for setbat(), I will double check.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

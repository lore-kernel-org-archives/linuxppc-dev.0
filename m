From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "David Updegraff" <dave@cray.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405GPr
Date: Mon, 10 Jun 2002 16:23:41 +0200
Message-ID: <EFEAIMDCOOOHIEPHDNFJIENAEAAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3D04A571.4020309@cray.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

> We got one in I made some "proof of concept" changes to PPCBOOT/LinuxPPC
> to make it boot ok.. have not played with the extra clocking
> register strap values though; we just plopped it into our
> 405GP socket and ran @200 Mhz.  Worked...

Good news :-).

> I noticed that the PVR on the unit we got was a bit different:
> ibm specs said
> 	0x50910950
> ..but I got
> 	0x50910951
>
> Is there a doc. somewhere that tells us what the ranges of PVRs
> for this chip can legitimately be?

The data sheet only mentions 0x50910950, but the errata refers to pvr
0x50910951 (Revision B?). What revision is printed on your ppc? Our chips
are labeled: 405GPr3BB266 (Rev B.).

Ciao,
Stefan.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

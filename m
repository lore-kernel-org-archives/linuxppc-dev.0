MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: VME - PowerPC: Resource sizes
Date: Thu, 10 Jun 2004 08:03:06 -0500
Message-ID: <DB1DE297F535B340AEAE1E51B221C3D0016B3DE3@FTWMLVEM02.e2k.ad.ge.com>
From: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
To: <okorpil@fh-landshut.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> We could iterate the PCI bus tree to the top (there is some
> parent bus
> field, IIRC), and then start complete iteration until a suitable
> resource is found. This may produce larger resource regions with
> reasonable effort.

On the x86 boards we've dealt with we've gotten away with opening
VMEbus windows in PCI space not allocated by the Universe's parent
bridge because the parent bridges have always been set up for
subtractive decoding. So if no one else claimed the cycle, it got
passed down through the bridge to the Universe anyway.

> Are you sure you mean 768 _KB_ and 2 _MB_, not 768 _MB_ and 2
> _GB_? My SLSI window is already 64 MB big.

My bad. It's actually 768KB and 2GB are correct. The SLSI window
does fail to allocate with the patch.

daniel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "Flavio Pereira" <fpereira@azisa.com>,
	"Yu Bo-BOYU1" <Bo.Yu@motorola.com>,
	"linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260 configuration 
Date: Wed, 2 Oct 2002 08:07:58 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFEEMMDMAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20021002144757.8BCDFFA99@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > One "start" address that is not fixed is the initial load
> > > address. Where the
> > > kernel is put in RAM with decompressing etc. You should have to
> > > worry about
> > > this if you are using one of the available boot loaders.
> >
> > Sorry, should NOT have to worry about that address...
>
> Wrong, you SHOULD worry about this address. Load the kernel to a  low
> enough  address  (say  at  0x10000)  and  the uncompressing code will
> probably overwrite the kernel image.

The point is if you are using one of the available boot loaders, it normally
takes care of loading and decompressing the kernel. If you have the urge to
experiment with the load address, then you are right. Normally this is
out-of-sight, out-of-mind.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

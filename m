Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Flavio Pereira" <fpereira@azisa.com>,
	"Yu Bo-BOYU1" <Bo.Yu@motorola.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260 configuration
Date: Wed, 2 Oct 2002 07:04:42 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFIEMIDMAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1E354700654661418593A0D6B5A9D410A36223@mail.azisa.co.za>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> 2. The start address is fixed to 0x0
>

One "start" address that is not fixed is the initial load address. Where the
kernel is put in RAM with decompressing etc. You should have to worry about
this if you are using one of the available boot loaders.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

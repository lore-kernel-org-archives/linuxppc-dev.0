Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Flavio Pereira" <fpereira@azisa.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux on 8260 using ELDK..Help?!?
Date: Wed, 4 Sep 2002 06:55:13 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEKFDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1E354700654661418593A0D6B5A9D41008943B@mail.azisa.co.za>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Warning: unable to open an initial console.
> Restarting system.
> Oops: machine check, sig: 7

Looks like you are missing the console device. Check your /dev
configuration.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

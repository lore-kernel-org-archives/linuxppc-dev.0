Date: Wed, 3 May 2000 23:53:20 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
cc: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FireWire chip on PISMO?
In-Reply-To: <39111625.9D1FD101@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.3.96.1000503235136.6574O-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 4 May 2000, Albrecht Dreﬂ wrote:

> Does anyone know where I could find information about the FireWire
> controller chip which is used in the Apple PISMO Powerbook?

It's a standard OHCI chip, probably repackaged in a custom ASIC, but it
works with the same drivers as all the other OHCI devices.  You should
only need to add an extra ID in your supported device lists for the linux
drivers to support it.  If the driver doesn't work out of the box, there's
a driver bug in general.  :-)


Later,
David

---------------------------------------------------------------------
A logician trying to explain logic to a programmer is like a cat
trying to explain to a fish what it's like to be wet.

	-- unknown, possibly Franklin Veaux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

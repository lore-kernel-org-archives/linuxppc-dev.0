Mime-Version: 1.0
Message-Id: <v04220803b5381a8fbf73@[10.0.0.42]>
In-Reply-To: <39111625.9D1FD101@mpifr-bonn.mpg.de>
References: <39111625.9D1FD101@mpifr-bonn.mpg.de>
Date: Thu, 4 May 2000 23:29:54 -0700
To: Albrecht Dreﬂ  <ad@mpifr-bonn.mpg.de>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: FireWire chip on PISMO?
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:18 AM +0200 5/4/00, Albrecht Dreﬂ wrote:
>Does anyone know where I could find information about the FireWire controller
>chip which is used in the Apple PISMO Powerbook?  lspci tells me that it was
>made by Apple, device id 0x0018, and I think this one is not (yet)
>supported by
>the FireWire-for-Linux stuff.

It's a OHCI FireWire controller inside of Apple's Uni-N custom ASIC.
Since it's OHCI, support should theoretically be a matter of just
letting the FireWire code know about its device ID (if it doesn't
already).

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

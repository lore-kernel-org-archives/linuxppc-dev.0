Message-ID: <38E21E97.64D20258@iiic.ethz.ch>
Date: Wed, 29 Mar 2000 17:17:43 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Alain RICHARD <alain.richard@equation.fr>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: new XFree86 4.0 rpms
References: <200003291145.DAA39678@bromo.med.uc.edu> <p04310105b507c981404f@[192.168.240.10]>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alain RICHARD wrote:

> I have made a configuration that seems to be working (the screen,
> resolution and fbdev driver is loading without any error), but the
> screen is erased and remains black.

You need to specify a BusID (in your case 'BusID "PCI:0:16:0"') in the Device
Section for the fbdev driver to work.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

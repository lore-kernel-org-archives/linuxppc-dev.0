Date: Wed, 3 Jan 2001 21:53:20 +0100
From: Olaf Hering <olh@suse.de>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound and 2.2's dmasound
Message-ID: <20010103215320.A4451@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <200101031947.TAA19299@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200101031947.TAA19299@hyperion.valhalla.net>; from iain@sandoe.co.uk on Wed, Jan 03, 2001 at 07:47:36PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 03, Iain Sandoe wrote:

> (and also there's the start of an ALSA version - from a posting on the
> ALSA-dev list yesterday)...

There are results.
ftp://ftp.suse.com/pub/suse/ppc/kernel/2.2.18/k_pmac-2.2.18-0.ppc.rpm
http://penguinppc.org/~olaf/alsa/alsa-0.5.9-38.ppc.rpm
http://penguinppc.org/~olaf/alsa/alsamixergui-0.5.7-0.ppc.rpm
ftp://ftp.suse.com/pub/suse/ppc/7.0/suse/xdev2/fltk.rpm
http://penguinppc.org/~olaf/alsa/modules-alsa.conf

echo "include /etc/modules-alsa.conf" >> /etc/modules.conf
(disable dmasound.o, just unload it)


everything that works with dmasound.o should still work.
iMac sound works (internal speaker), B&W internal speaker. iBook doesnt
work yet, but this guy had the iBook only for a few minutes ;)

There are no alsa modules in
ftp.suse.com/pub/suse/ppc/kernel/2.4.0-test13/k_ppc23-2.4.0_test13pre3-0.ppc.rpm
because the Makefile was buggy, I will update it these days.


Please test it, I'm not a multimedia guy ;)


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

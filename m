Return-Path: <GRuescher@dspace.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: How can I get a ramdisk.image for linux2.6 running on ML403?
Date: Tue, 29 May 2007 16:20:38 +0100
Message-ID: <18A49CF3586FC14290887ECC63C9141F0104D0CF@exchange2003.dspace.de>
In-Reply-To: <fa686aa40705290701h590998bfjc36385fa08a821d0@mail.gmail.com>
From: "Gerald Ruescher" <GRuescher@dspace.de>
To: <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely <grant.likely@secretlab.ca> wrote:

> On 5/29/07, angelalinyao@163.com <angelalinyao@163.com> wrote:
>
> > Is there any ramdisk.image provided for linux 2.6?
> > Or maybe I have to make a ramdisk by myself?
> > [...]
> > Any help from you is appreciated.Thank you!
>
> If you just want an out-of-the-box ramdisk, you can use the one in =
ELDK
>=20
> http://www.denx.de/wiki/DULG/ELDK
>=20
> Or, you can mount your existing ramdisk image on another Linux box and
> copy the needed files over.  The /dev entries are the same across all
> architectures.

Additionally I'd like to point out that there is a nice and
well-written O'Reilly book called "Building Embedded Linux System"
by Karim Yaghmour.  It contains a number of useful hints and techniques
for newbies, including a chapter about how to set up a root file
system for an embedded system using tools like BusyBox etc.
Some chapters may not be 100% up-to-date but still recommended=20
reading.

Kind regards,
Gerald

______________________________________________

Gerald R=FCscher
Software Development Engineer
Core Real-Time Implementation

dSPACE GmbH          Tel.:  +49 5251 1638-1826
Technologiepark 25   Fax:   +49 5251 16198-1826
33100 Paderborn      http://www.dspace.de
Germany              mailto:GRuescher@dspace.de
_______________________________________________

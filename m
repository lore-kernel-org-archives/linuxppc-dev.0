Date: Fri, 3 Dec 1999 14:42:04 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: ml-linuxvme@vespa.unix-ag.uni-siegen.de
cc: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.rutgers.edu
Subject: [Announce+RFT+RFC] VME for Linux (on some boards at least)
Message-ID: <Pine.HPP.3.96.990427055644.20020J-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



	Hi,

I have put patches and tarballs in the following directory:

	ftp://vlab1.iram.es/pub/linux-vme/

this is a driver and more stuff for PPC and Intel machines using Tundra's
Universe PCI<->VME bridge. There is already a driver for this chip
floating around but mine is completely different since it also provides
services to additional kernel drivers to access VME, register interrupt
handlers, queue DMA opperations etc... A few examples of such drivers are
available, actually one of my goals was to make writing board specific
drivers as simple as possible and independant of the physical interface
used to access the VME bus (there is at least another chip called Alma
which is similar to the Universe but I don't even have the doc yet).

However you should note the following:

- people with Motorola MVME2xxx boards should rather look in the linux-2.2
directory since there are additional specific patches for these boards
which improve on the default firmware setup (and a specific bootloader).

- documentation is in progress, please bear with me while I finish it in
the middle of numerous other things...

- I have a couple of machines in production since 2 months ago without any
problem which can be traced to the VME drivers (there was a bug in the
application)

- my only test platform is PPC. The driver was checked to work a
few months ago on an Intel/VME machine but something will certainly be
broken now. This should be minor however...

- I certainly have forgotten some important facts which I wanted to
state only five minutes ago, oh well...

	Cheers,
	Gabriel.

P.S: the proper forum for this is ml-linuxvme, but this list is so silent
that I decided to post this message to more active lists. Please trim the
cc: list before replying.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

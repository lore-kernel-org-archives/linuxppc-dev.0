Message-ID: <319E391E2049D311843500609457383D07FC4E@exchange.vividimage.com>
From: Kirk Haderlie <khaderlie@vividimage.com>
To: "'Navin Boppuri'" <nboppuri@myiagent.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: FADS823 Communication
Date: Mon, 12 Jun 2000 09:13:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am not aware of any mpc8bug like program that can be run under linux, but
mpc8bug is really on necessary to get the 8xxrom code into the flash. We
recently brought up a FADS board using the mpc8bug to load 8xxrom available
at http://www.s4l.de/powerpc.html into the flash.  We modified 8xxrom to do
a simple tftp load of the kernel into memory then unzipped it and jumped
into it.  The kernel was configured to NFS mount it's root file system. Once
we had that working we ran inetd so we could telnet to the FADS board.  It
works well because the NFS root file system is on a PPC machine running
PowerPC Linux, so we build executables in directory which is mounted for the
NFS root and have them instantly on the FADS board.

-----Original Message-----
From: Navin Boppuri [mailto:nboppuri@myiagent.com]
Sent: Monday, June 12, 2000 2:40 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: FADS823 Communication



I am newbie and have been asking all sorts of questions on working with the
FADS board. My next question is how can I communicate with my FADS board if
my host is a Linux box? Both the SDS Diab and the EPC Bug are set up on  a
Windows environment. How can I make it work on Linux?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

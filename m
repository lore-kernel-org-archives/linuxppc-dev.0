From: "Navin Boppuri" <nboppuri@myiagent.com>
To: "Kirk Haderlie" <khaderlie@vividimage.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: FADS 823
Date: Thu, 15 Jun 2000 18:22:03 +0100
Message-ID: <NEBBLLEGJMLHPJEFEOKPCEBPCAAA.nboppuri@myiagent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <319E391E2049D311843500609457383D07FC57@exchange.vividimage.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Kirk,

I followed all the instructions on the web site correctly. I installed
patches for kernel and 8xxrom. I successfully compiled the kernel modules.
All the files in the 8xxrom compile almost correctly expect for the serial.o
file which gives me an error in one of its include files, the commproc.h
 error! Undefined configuration). When I scan the commproc.h file, I
understand that error shows up when CONFIG_SCC1_ENET or CONFIG_SCC2_ENET are
not defined. But I do the MP8XX CPM configuration during the kernel
configuration and set the SCC2 for ethernet which should define this
variable. I dont understand how this can be wroing?

Navin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

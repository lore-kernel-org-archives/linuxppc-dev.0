Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB389@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: 405GPr PCI target/host
Date: Thu, 19 Aug 2004 14:28:00 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to get an IBM 405GPr processor to work as a target/host on a PCI
bus.  A PCI target can temporarily become a host on the PCI bus. Basically
this means it needs to do everything the host currently does except
assigning PCI memory space, the dedicated host is responsible for this.

I saw a message concerning this on Tue 12/23/2003 4:20 PM, the questions was
for "MPC7447(Dual CPU) + MV64360 based Processor PMC boards"  I only saw one
response to this and it did not seem to be correct.

I was wondering if anyone has done something like this, not necessarily with
a 405, any processor experience will do.  I appreciate any help or advice.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

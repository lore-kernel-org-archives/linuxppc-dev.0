Message-Id: <200202140825.JAA24865@post.webmailer.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Okke Wald <okke.wald@ki.comcity.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux on IBM Thin Client with ppc 603?
Date: Thu, 14 Feb 2002 09:31:28 +0100
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI all,

I have many IBM Network Station 1000 Thin Clients and I would like to run
Linux on them. They have a ppc 603eV @ 200MHz, PCI bus, and  common Ethernet
interface and VGA. They are booting an IBM kernel (ELF format) from a server
by NFS or TFTP. Because I think booting over network is common for embedded
boards I am posting here...

I tried to download a SuSE PPC kernel image (just for fun) The boot monitor
starts downloading the kernel, but it displays a wrong size (much smaller
than the kernel) and gives an error message before starting the kernel
(corrupt kernel image or so). Is this common, or should I expect that the
firmware does a checksum calculation so that using a linux kernel isn't
possible?

I am completely new in linux ppc computing. I will be pleased if you give me
some hints on how to start. ;-)

Kind regards,
Okke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

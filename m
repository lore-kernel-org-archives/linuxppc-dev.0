Date: Thu, 23 Oct 2003 18:01:00 +0200
From: xavier grave <grave@ipno.in2p3.fr>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI mapping for a MVME5500
Message-ID: <20031023160100.GA8653@ipnpcu9.acq.ami>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

We just have received a new mvmv5500 from motorola.
It runs with linux-2.4.20 kernel (std tree) + motorola patches.

I have a driver for the universe chip (which runs for mvme2300 &
mvme5100). But here it cant allocate pci memory space because the pci
bridge (upon the tundra chip depends) had only 1 MB memory allocate by
the system. For my VME spaces I need many more, does anybody know where
I can try to modify this 1MB allocation ?

Thanks in advance, xavier

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

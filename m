Message-Id: <m12NRsU-001SwhC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Current state of MPC8260 Linux
To: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org
Date: Tue, 22 Feb 2000 21:50:13 -0500 (EST)
Cc: all@cideas.com
In-Reply-To: <0FQB00A8FULE7R@pmdf-it.hasler.ascom.ch> from "Ruedi.Hofer@ascom.ch" at Feb 22, 2000 11:30:42 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	* My observations as to the current state of the MPC8260
	version of Linux:

	{

	 If anyone has additional wisdom on this topic, please send it to
	 the mailing list <linuxppc-embedded@lists.linuxppc.org> or
	 Jon Diekema <diekema_jon@si.com>

	}

	- MontaVista Software, http://www.mvista.com/, and at least one other
	  company contracted with Dan Malek <dan@netx4.com> to perform the
	  MPC8260 Linux port.  Dan Malek was heavily involved with the MPC8xx
	  Linux port, so he was a natural choice to do the MPC8260 port.

	- The Linux kernel is covered by the GPL, GNU Public License, version
	  2.  See the COPYING from the Linux kernel distribution.

	  From the GPL version 2:

	  "2. You may modify your copy or copies of the Program or any portion
	      of it, thus forming a work based on the Program, and copy and
	      distribute such modifications or work under the terms of Section 1
	      above, provided that you also meet all of these conditions:

	      ...

	      b) You must cause any work that you distribute or publish, that in
	      whole or in part contains or is derived from the Program or any
	      part thereof, to be licensed as a whole at no charge to all third
	      parties under the terms of this License."

	  Therefore, MontaVista software is compelled to release their MPC8260
	  changes back to the Open Source community, however the timing
	  isn't defined.  I would expect MontaVista to release these changes
	  either before or shortly after their MPC8260 work is released.

	- Paul Staudacher <paul_staudacher@mvista.com>, Sales,
	  indicated that MontaVista will be releasing the MPC8260 Linux changes,
	  but it is not currently scheduled.

	- Jim Lewis <jlewis@mvista.com>, Sr. Field Applications Engineer, told me
	  that a production MPC8260 Linux release for the EST SBC8260 board,
	  http://www.estc.com/products/SBC/SBC8260_8240.html, is targeted for
	  May/June 2000 timeframe.

	  I asked Jim Lewis what features of the SBC8260 will be supported.
	  Here is his response:

	  From Jim Lewis <jlewis@mvista.com>:

	  Right now, we have data cache turned off because Cache Snooping is
	  not working. We are using 10 Mbit ethernet on an SCC rather than
	  100MBit on an FCC. The first release will have those two things fixed
	  at a minimum. So here is a minimum list of features:

	         NFS or Initial Ram Disk Root FS
	         Async serial using SMC's
	          Ethernet on SCC
	         10/100 Ethernet on FCC
	         Proper cache operation
	         x86 Linux hosted C/C++ Cross Dev environment
	         Remote GDB KErnel debug over serial
	         Remote GDB application debug over Serial/Ethernet

	- MontaVista makes its money through annual support contracts
	  per contribution engineer.  A contributing engineer is defined to
	  be anyone making a software contribution to the project.  The
	  support costs aren't inexpensive, however you usually get what
	  you pay for.  For the details on the MontaVista pricing, you
	  should contact Paul Staudacher <paul_staudacher@mvista.com>.

	- The PPC Linux development is being done with the BitKeeper tools,
	  http://www.bitkeeper.com/.  In order to get the BitKeeper tools,
	  you need to fill out an NDA.  The BitKeeper developers are scrambling
	  to make the tools work for the PPC Linux developement people.

	  I have filled out a NDA, and both FAXed and US mailed the NDA to BitKeeper.
	  I am waiting for a download login and password, but haven't received
	  it yet.  I called BitKeeper and they returned my call on the same day :).
	  They explained they were dragging their feet on adding more people to
	  the Beta program because of an antipicated file format change that
	  was going to happen in the next week.  This change would force everyone
	  to use a new release of the BitKeeper software.

	  BitKeeper wanted me to avoid the hassle of performing the upgrade.

	  It has been week since the telephone conversation with BitKeeper,
	  and I am still waiting to get the software.  I suspect they are
	  under the gun in getting the bugs worked out.

	- The PPC Linux development bits are available with rsync,
	  http://rsync.samba.org/rsync/, from daily snapshots of the
	  BitKeeper repository.

	  rsync -avz --delete hq.fsmlabs.com::linuxppc_2_3 linuxppc_2_3
	  rsync -avz --delete hq.fsmlabs.com::linuxppc_2_2 linuxppc_2_2

	  By looking at what files are changing, you get a sense of what the
	  developers are working on.  I would rather have access to the
	  BitKeeper tools first hand, so I could see who is doing what.

	- The PPC Linux develeopment BitKeeper repository is being hosted
	  by Finite State Machine Labs, FSMLabs, http://hq.fsmlabs.com/.
	  FSMLabs is a service of VJY Associates, LLC.

	  Who is FSMLabs?

	  From http://hq.fsmlabs.com/:

	  "Created by the developers of RealTime Linux (RTLinux[tm]) and one of
	  the main developers of PowerPC Linux, FSMLabs provides operating systems
	  support to commercial vendors of products based on Linux. Providing core
	  kernel expertise and development, we consult on general systems issues
	  with a focus on real-time and embedded systems used in industry and
	  research. In addition, we have cooperative arrangements with companies
	  that provide direct customer support, systems integration and
	  application development."

	  FSMLabs are people behind RTLinux.

	  Cort Dougan is involved with FSMLabs, and Cort has his name on
	  the http://www.ppc.kernel.org/ web site.

	- Hints on how to use BitKeeper, BK:

	  http://lists.linuxppc.org/listarcs/linuxppc-dev/200002/msg00193.html
	  http://lists.linuxppc.org/listarcs/linuxppc-dev/200002/msg00220.html
	  http://lists.linuxppc.org/listarcs/linuxppc-dev/200002/msg00221.html

------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

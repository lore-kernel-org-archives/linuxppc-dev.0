To: linuxppc-dev@lists.linuxppc.org
Subject: Misc problems with Lombard (serial, ethernet, SCSI)
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 24 Sep 2000 19:57:41 -0500
Message-ID: <m2vgvlthiy.fsf@c469597-a.grlnd1.tx.home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a Powerboot 1999 and I'm having a few annoyances with it.  I'm
currently using the stable rsync kernel from linuxcare.  The following is
happening:

* Serial drivers - At least when talking to the modem, it will occasionally
  cease to work.  I use pppd to connect, and when it disconnects I cannot
  reconnect.  Once this happens, anything that tries to open the port get
  an I/O error.  If I unload the serial module and then reload it, the
  problem goes away for a while.  This started happening around 2.2.15.

* MESH Driver - It won't work with my scanner.  The scanner works fine
  under MacOS and used to work under Linux x86.  It has problems with
  disconnects.  Also, once I use it then sleeping and awaking will locks up
  the machine.  Also, unloading the MESH module and reloading it locks up
  the machine.

* Ethernet driver (BMAC) - The driver will occasionally lock up under heavy
  load (I haven't seen this yet with 2.2.17, though).  If I define an alias
  address, bringing down the alias address will also bring down the main
  address (this is still happening under 2.2.17).  Unloading the ethernet
  driver and loading it again causes a lockup.

I'm also seeing random lockups after long periods of running under
heavy load, but this is new and I'm thinking it may be a heat problem.
But just in case, I'll say it.

I'm posting this to see if anyone is aware of these problems.  I'm
willing to work on them, but I don't want to duplicate work.  But I
would like to hear from the responsible parties for each driver to
know what to do.

Thanks,

Corey

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

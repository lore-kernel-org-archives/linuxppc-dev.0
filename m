Message-ID: <8177F6132F4D7F43AD9E832D5AAAEE2441ACC8@il02exm04.corp.mot.com>
From: Hawkins Jeffrey-CJH016 <Jeffrey.F.Hawkins@motorola.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Lost TCP Message ????
Date: Thu, 13 Jun 2002 12:12:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Problem:
	We have an Multi-Threaded Application that has an SMUX (TCP/IP)
      Connection to the SNMP Daemon.  The Connection Network Interface
      is the Local Device (lo, 127.0.0.1).  When sending a "burst" of 64
      SNMP Traps, each 150 bytes, we intermittently see that although
      the Sockets "send" Function indicates successful transmission,
      the TCP Message is not transmitted -- not received by
      the SNMP Daemon (TCP Server), nor seen in the Network Traffic
      Monitoring Output from TCPDUMP.  If we add delays between
      each transmission, then every Message is transmitted successfully.
      So either there is a bug in the GLIBS Socket Support, or a bug
      in the Kernel TCP/IP Stack.

Hardware Platform:
	Embedded Platform using Motorola MCP750 cPCI Host Board

Relevant Software Version Info:
	Kernel 	= 2.2.17
	GCC	 	= 2.95.3-2f
      GLIBs  	= 2.1.3-5a
	UCD-SNMP	= 4.2.4

Has anyone encountered similar problems and/or know if this has been
corrected in Kernel, GLIBs, etc... ?  Since the Application is for
a Commercial Product, I need to have a source to the problem, and not
just go blindly migrating to new Kernels/Tools, and hope it has been
fixed...  I am somewhat locked into the Software Platform (has to be
a 2.2.x Kernel).  Looking at the Kernel Notes, and the Kernel Network
Stack, I noticed there have been a number of fixes/enhancements between
2.2.17 and the latest 2.2.x Release, but nothing really stands out as
being the "silver bullet".

Any help would be greatly appreciated...:)

Jeff

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

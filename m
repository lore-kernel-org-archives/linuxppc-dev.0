Message-Id: <m12Gmzf-001SweC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Looking for the PPC gdb debug stubs
To: bgat@usa.net
Date: Fri, 4 Feb 2000 12:58:07 -0500 (EST)
Cc: all@cideas.com, linuxppc-embedded@lists.linuxppc.org,
        gdb@sourceware.cygnus.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	To: Bill Gatliff
	    bgat@usa.net

	Subj: Looking for the PPC gdb debug stubs

	In your 9/99 article in Embedded Systems Programming, you hint
	about the Power PC gdb debug stubs being in progress.  Can you
	provide with any details like:

	- Is the effort complete?
	- If so, where can I find the PPC gdb debug stubs?
	- Who are the people involved with the activity,
	  and how can I get in touch with them?

	Our initial hardware target is the EST SBC8260 board.  The MPC8260
	supports a COP/JTAG port.  I wondered if gdb has or is the progess
	of supporting the MPC8260 Macraigor Wiggler?  From the gdb version
	4.18 source code, it appears that gdb supports the MPC860
	Macraigor Wiggler.

	Note: The MPC860 and MPC8260 Wigglers are very different animals.

	Reference:

	http://www.embedded.com/1999/9909/9909feat2.htm

	I have posted my attempt at a portable debugging stub on ESPs Web
	site, at ftp://ftp.mfi.com/pub/espmag/1999/gdb. This source code
	has been compiled and tested for the Hitachi SH-2, and ports are
	underway for the Hitachi H8, Power PC, and other processors.

	Who is Bill Gatliff?

	Bill Gatliff is a freelance embedded developer and senior design
	engineer with Komatsu Mining Systems, Inc. in Peoria, IL, and is a
	semi-regular presenter at the Embedded Systems Conferences. He can
	be reached at bgat@usa.net.

	GDB: The GNU Debugger
	http://sourceware.cygnus.com/gdb/

	GDB Mailing Lists
	http://sourceware.cygnus.com/gdb/lists.html
	gdb@sourceware.cygnus.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

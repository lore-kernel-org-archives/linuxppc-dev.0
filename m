To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: gdb and NPTL
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Mon, 05 Jul 2004 11:10:59 -0400
In-Reply-To: <1089036206.6006.27.camel@lucy.pep-kaufbeuren.de> (Stefan
 Nickl's message of "Mon, 5 Jul 2004 10:03:27 -0400")
Message-ID: <wn5y8lymqv0.fsf@linhd-2.ca.nortel.com>
References: <1089036206.6006.27.camel@lucy.pep-kaufbeuren.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

We're migrating out target (proprietary ppc-7447/discovery based
board) from VxWorks to 2.6.7 and NPTL. Building/running multi-threaded
applications is fine but gdb (6.1,6.1.1,cvs) doesn't work. I keep
complaining about cannot find new threads and and the app died with:

        "Program terminated with signal SIGTRAP, Trace/breakpoint trap"

both native and remote debugging had similar problems.

Any suggestion/help would be really appreciated.

--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

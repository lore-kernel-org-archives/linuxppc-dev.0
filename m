From: dale@farnsworth.org
Date: Sat, 3 May 2003 06:26:21 -0700
To: Chris Heintzelman <heintz@mail.utexas.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Early linuxppc_2_4 MGT5100 tree available
Message-ID: <20030503132621.GB22716@rover.farnsworth.org>
References: <3EA70BDE.9080609@mail.utexas.edu> <20030424020846.GA1283@rover.farnsworth.org> <3EA8035E.3040705@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EA8035E.3040705@mail.utexas.edu>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As I said earlier, I've started to port linux to the Motorola MGT5100
processor.  I've put up a bk tree based on linuxppc_2_4_devel at
source.mvista.com.  See <http://source.mvista.com> or
<bk://source.mvista.com/linuxppc_2_4_mgt5100>.

It includes drivers for the on-chip serial and ethernet controllers.
I have a Glacier system, so that's what I've been testing on.  Kent Borg
provided support for the Icecube system, but I've made changes since
so blame any problems on me.

The serial driver seems solid.

The ethernet driver is usable.  I'm having problems with the interface
to the SmartComm/SmartDMA engine ethernet task code.  So far, I have
to slow down ethernet performance to get reliability, but I expect to
resolve this soon.  The ethernet driver doesn't have MII support yet,
so it is not expected to work, as is, with the Icecube.

Please send suggestions and/or patches.

I thank MontaVista for supporting me in this work and for encouraging
me to share it with the community.

-Dale Farnsworth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

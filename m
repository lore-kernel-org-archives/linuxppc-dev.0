Date: Tue, 11 Apr 2000 15:19:58 -0400
From: Josh Huber <huberj@wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Preserving memory...
Message-ID: <20000411151958.H771@mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey, I'm working to get some in-memory crash dump kernel patches, and I've
run into some problems.  I've got a couple of questions that I hope someone
can answer for me:

First, is there a way to tell powerpc hardware (Macs in particular -- for
now) to preserve memory across a system restart?  It looks like it does this
by default, partially.

Secondly, if I can get the first part to work reliably, does anyone know
what regions of memory should be avoided, i.e. are thrashed by OF etc?

Thanks,
Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <388F3D65.3B420FED@ctam.com.au>
Date: Thu, 27 Jan 2000 05:31:01 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc-embedded: main kernel tree
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

How seperate is the Linux/PPC kernel tree to the main kernel tree ?

I download linux-2.2.14 and there is only support for MBX (no BSEIP and
others).  I'm not sure if the MBX is the latest either.  I suspect it
hasn't changed much anyway.

Can support for all the embedded ports be put into the main kernel
source tree.
That way we can all use the latest stable kernel without having to wait
for you (or someone else) to create a package on the ftp server.  It
also reduces the re-porting of board support packages.

How often is the Linux/PPC kernel for workstations (PowerMacs, etc)
committed to the main kernel tree ?

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <382B4396.57669F9B@ctam.com.au>
Date: Fri, 12 Nov 1999 09:30:47 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linux-embedded <linux-embedded@waste.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: LinuxEmbedded: minimal network system packages.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've just managed to get LinuxPPC (embedded-2.2.5 kernel) to boot on my
custom MPC860 board using the initrd boot method.  I haven't got the
nfs-root working yet but I imagine this shouldn't present too many
problems.

I want to be able to run FTP (client only), HTTP server, SNMP agent and
TELNET server.
What packages do I need to compile (cross-compile) to get these working
?

Things I think I need are :
* init
* mount (do I NEED this ?)
* ifconfig (do I NEED this ?)
* inet
* ftp, http, snmp and telnet software.

Any pointers to documentation about getting a minimal embedded networked
system up and running.

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3937F5E7.363DAA1@aminocom.com>
Date: Fri, 02 Jun 2000 17:59:03 +0000
From: Elizabeth Clarke <eclarke@aminocom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Java
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get jdk118_v2 from linuxppc.org/java to work, but get an
error loading the shared libraries libc.so.6 with __register_frame_info
missing.

I'm using glibc1.1.2 from mvista, and defaulting to green_threads. My
research has thrown up that libraries compiled with gcc and binaries
compiled with egcs are incompatible. Has anyone else encountered this
problem, did you resolve it, and how? please.

Thanks,
Beth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

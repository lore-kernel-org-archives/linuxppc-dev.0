From: "\"Jeffrey D. Kowing\" <Jeff Kowing" <jeffrey.d.kowing@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14716.40297.722650.146957@igor.jsc.nasa.gov>
Date: Mon, 24 Jul 2000 14:47:53 -0500 (CDT)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Ramdisk using libc5
In-Reply-To: <397C9915.74D84EA1@cyclades.com>
References: <397C9915.74D84EA1@cyclades.com>
Reply-To: jeffrey.d.kowing@jsc.nasa.gov
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You need to strip libc-2.1.2.so, i.e.,

$ strip libc-2.1.2.so

to remove the debugging symbols.  It should reduce it to around 1 MB.

Edson Ap. Seabra writes:
 >
 >         I want to make a ramdisk image for a PPC board that provides
 > basic network services
 > such as ping, telnet, traceroute and ftp. I would like the final memory
 > image size less than 2 Mb. Only libc-2.1.2.so has 4 Mb.
 >
 > Has  somebody  done this using libc5 ?
 >
 >

--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

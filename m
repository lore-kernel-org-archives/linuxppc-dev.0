Message-ID: <200006021710.NAA19138@hoover.gilbarco.com>
From: "Banks, Kelly" <kelly_banks@gilbarco.com>
To: "'Elizabeth Clarke'" <eclarke@aminocom.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: Java
Date: Fri, 2 Jun 2000 13:10:45 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was hitting the exact same error & wound up tracking it into the
libtermcap.2.0.8 that I was using...  Mine went away when I used the termcap
available from Mvista.


-----Original Message-----
From: Elizabeth Clarke [mailto:eclarke@aminocom.com]
Sent: Friday, June 02, 2000 1:59 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Java



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

Message-Id: <39FD8ADF.268A4CE1@fht-esslingen.de>
Date: Mon, 30 Oct 2000 15:51:11 +0100
From: Matthias Kienle <Matthias.Kienle@fht-esslingen.de>
Reply-To: Matthias.Kienle@stz-softwaretechnik.de
Mime-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Building a AIX Cross Compiler
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi *,

I try to structure a cross compiler. The binutils were already
successfully compiled (with a gcc bin packages for aix). Unfortunately I
receive an error during compiling the gcc-core. I compile the packages
with a AIX 4.3 system. I use a gcc compiler (bin packages for aix) to
compile the gcc-core (same as I used for the binutils). The error output
shows me trouble with the ld. ld returned 12. The text which comes with
the return code is:

ld: 0711-781 ERROR: TOC overflow. TOC size: 68908       Maximum size:
65536
collect2: ld returned 12 exit status

Is there anybody who could help me?

ciao Matthias

+---------------------------------------------------------+
| Matthias Kienle                                         |
|    Fachhochschule fuer Technik Esslingen                |
|    (mailto:Matthias.Kienle@fht-esslingen.de)            |
+---------------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

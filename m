From: Ruedi.Hofer@ascom.ch
Date: Mon, 02 Oct 2000 16:04:16 +0100 (CED)
Subject: Re: Re: Re: Re: Re: VxWorks bootloader & PowerQUICC II,
 Booting the kernel
To: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Message-id: <0G1T00K833EN6L@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_g/dUnbAMlZMxFef8EMuM+g)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_g/dUnbAMlZMxFef8EMuM+g)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Jon & Gerald

Thanx for the patches. The kernel compiles now well and even the download
to the SBC8260 seems to work. It downloads 2 sections, perfect.

After having copied parts of embed_config.c to my kernel I get:

[VxWorks Boot]: g 400000
Starting at 0x400000...

loaded at:     00400000 0040B278
zimage at:     0040B278 0047C37F
avail ram:     0047D000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
<crash>


I think I better move to a later kernel than -test2 !


Thank you

\Ruedi


--Boundary_(ID_g/dUnbAMlZMxFef8EMuM+g)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

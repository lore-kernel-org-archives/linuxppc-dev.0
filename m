From: Ruedi.Hofer@ascom.ch
Date: Tue, 03 Oct 2000 16:15:33 +0100 (CED)
Subject: VxWorks Bootloader, PowerQuicc II, HHL1.2
To: linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0G1U002DRYBDLP@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_eGNhMvxyPmND48jgsemcjw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_eGNhMvxyPmND48jgsemcjw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

I try to boot Linux on my SBC8260 PowerQuicc II evaluation board using
HHL1.2.

I'm now able to decompress the kernel but booting doesn't work.


[VxWorks Boot]: g 400000
Starting at 0x400000...

loaded at:     00400000 0040B278
zimage at:     0040B278 0047CBA6
avail ram:     0047D000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
<crash>


Did someone experience the same problem?

I checked the kernel 2.4.0-test8 out with the same frustrating result!

Do I have to provide some magic kernel params?

Thank you

Ruedi

--Boundary_(ID_eGNhMvxyPmND48jgsemcjw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

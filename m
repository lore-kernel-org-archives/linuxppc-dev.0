From: Ruedi.Hofer@ascom.ch
Date: Wed, 12 Jan 2000 13:11:03 +0100 (CET)
Subject: Antwort: Re: Antwort: 8xxrom wierdness, 2nd
To: damm@kieraypc01.p.y.ki.era.ericsson.se
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FO800BEL1WA5U@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_TtHWFpaG2I3U36+L6xzB9g)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_TtHWFpaG2I3U36+L6xzB9g)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Magnus

I see now why it doesn't crash anymore: 

You've put the line check_fs(); (disk.c; 151) into comments. ;-)


Cheers, Ruedi


BTW: 

- Do you have experience with the sandisk pc cards?

- I formatted the pc card on a win95 box. That should work, right?
  (At least the boot device list should mention something)

____________________________________________________________________



I just tried your 8xxrom. It seems to work a bit better than the Bossek original  ;-)

It generates the following output:

8xxROM 0.3.0

compiletime options:
board: ADS DRAM_25MHZ
disk: DISK_ATA PCMCIABUG

cpu: XPC860xxZPnnA3 at 25 MHz: 4Kbyte icache 4Kbyte dcache

<warning: cpu core has silicon bugs, check the errata>

board: ADS rev A - warning, read errata
flash: 2 Mbytes, delay 90 ns
dram: EDO, 4 Mbyte, 70 ns, OK
pcmcia: 5V and 3V
pcsr = 0x0070fe70

ATA disk: 'SunDisk SDP'.

Boot device list:Card Not Ready 0x0

disk: No disk found.

>

Do you have any ideas?

Ruedi

--Boundary_(ID_TtHWFpaG2I3U36+L6xzB9g)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

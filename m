From: Ruedi.Hofer@ascom.ch
Date: Mon, 31 Jan 2000 16:12:58 +0100 (CET)
Subject: RomFS
To: linuxppc-embedded@lists.linuxppc.org
Cc: damm@kieraypc01.p.y.ki.era.ericsson.se
Message-id: <0FP7006FSGXU3K@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_wT3K7biElrlfYxFL8Tl3fA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_wT3K7biElrlfYxFL8Tl3fA)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi,

My ADS board is happily running with a NFS mounted linux box.

Now I have to put all the code into the flash memory to get a standalone
solution.

I'm using the 8xxrom Bootloader. In a file called config.h I can configure
CONFIG_DISK_ROM.  As far as I can see, the bootloader assumes
then that a complete FAT filesystem is stored from the position
0xFE020000 in flash.

My question:
- Is my assumption right?

- How can I produce a FAT filesystem in a file, which I can download
  with MPC8BUG into the onboard flash?

- Does it have anything in common with the romfs driver which is supported
  by the kernel? (I think not)


TIA, Ruedi


--Boundary_(ID_wT3K7biElrlfYxFL8Tl3fA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

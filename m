From: Ruedi.Hofer@ascom.ch
Date: Thu, 21 Sep 2000 17:29:37 +0100 (CED)
Subject: Limon & PowerQUICC II
To: linuxppc-embedded@lists.linuxppc.org
Cc: systemboot@linux01.hasler.ascom.ch
Message-id: <0G1800HE5TPGL0@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_VKO2jQ5SH5S6P6gH0V9MAA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_VKO2jQ5SH5S6P6gH0V9MAA)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

I ordered an EST SBC8260 evaluation board and I finally got it!!!

As always I try to run Linux on it. First of all, I found the bootloader
Limon on the net, cross compiled it and tried to run it.

I failed!! Why??

Questions:

1. Does someone know the correct value of the reset word required
by limon?

 I use  04 38 02 05 for the 8 bit flash / 66MHz
  0c 38 02 05 for the 32 bit flash / 66MHz

2. Does limon run on the 32 bit flash or on the 8 bit flash?

3. I use the Abatron BDI to program the flash memory. Am I right
when I load the srec-file into the bdi and overwrite the first 4 bytes
with the reset word (then write the stuff to flash)?

4. I have set IMMR to 0xF000000. Is that correct for limon?

5. I read in the sourcecode that limon wants to run at 0xfff00100.
Where do I have to set this address? (In the enclosed memory map
I found a drawing sayin that the flash should be at 0xfe000000!)

6. Can someone provide the correct values for the BRx / ORx?
I used the ones from limon -> reset.c!


Thank you for any help

Ruedi

--Boundary_(ID_VKO2jQ5SH5S6P6gH0V9MAA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: Ruedi.Hofer@ascom.ch
Date: Mon, 23 Oct 2000 10:58:00 +0100 (CED)
Subject: Chipselect, Memory mapping, MMU on 8260
To: linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0G2V000BIKWTE1@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_+9l/HK9seRGdiyFFud6rKA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_+9l/HK9seRGdiyFFud6rKA)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

I have a general question about the startup of a 8260 based system.


Are the following assumptions right and in the correct order:

1. The bootloader sets all chipselects (Buswidth, startaddress, size).

2. The kernel relies on these values and doesn't change them. It doesn't
enable any additional chipselects.

3. The kernel sets up the MMU.

4. The kernel enables the the data and instruction cache.



\Ruedi

--Boundary_(ID_+9l/HK9seRGdiyFFud6rKA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

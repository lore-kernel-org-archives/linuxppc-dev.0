Message-ID: <01139FC052A0D411900B00508B9535FC047BC38F@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: The relationship between hhl 2.0 and FEC driver-- the diagnos
	tic information
Date: Thu, 27 Dec 2001 20:17:21 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is the dump information:
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
Ring data dump: cur_tx c0453040, dirty_tx c0453040 cur_rx: c0453000
 tx: 8 buffers
  c0453040: 9c00 002a 019d8b92
  c0453048: 9c00 002a 019d8c12
  c0453050: 9c00 002a 019d8c92
  c0453058: 9c00 002a 019d8d12
  c0453060: 9c00 002a 019d8d92
  c0453068: 9c00 002a 019d8e12
  c0453070: 9c00 002a 019d8e92
  c0453078: bc00 002a 019d8f12
 rx: 8 buffers
  c0453000: 8000 d692 00452000
  c0453008: 8000 03c0 00452800
  c0453010: 8000 8b0f 00451000
  c0453018: 8000 d72c 00451800
  c0453020: 8000 b8bb 00450000
  c0453028: 8000 9b45 00450800
  c0453030: 8000 6e2f 0044f000
  c0453038: a000 cfbf 0044f800
eth0: tx queue full!.

>From the BD status above, it seems that the FEC controller DOES NOT process the BDs.
But I did enable the FEC by setting required bits in both ECNTRL register and R_DES_ACTIVE, X_DES_ACTIVE registers.
where will be the problem?

Thanks a lot
rolf
-----Original Message-----
From: Liu HongXun-a16975 [mailto:a16975@motorola.com]
Sent: 2001Äê12ÔÂ27ÈÕ 19:31
To: linuxppc-embedded
Subject: The relationship between hhl 2.0 and FEC driver



Hi, all,
I am trying to make the FEC driver work under HardHat 2.0 for ppc. But it is really aching.
My board is based on MPC 857T. It has both FEC and UTOPIA interface.
The UTOPIA uses the Port D as its data channel. And the FEC uses the PCMCIA Slot A instead.
Actually, I have made the FEC work under the common linux 2.4.2, also under linux 2.4.4 from Wolf.
But when I tried to make it work under hhl 2.0, also based on linux 2.4.2, it failed.
I even tried to use the work fec.c under linux 2.4.4 to replace the on under hhl 2.0, but no use.
I wonder what is the problem? what should I do to let fec.c work under hhl 2.0?
Any suggestions are really appreciated!

Aside words: why can't I set the UT bit of Port D PAR? when I try to set that bit, the kernel just
bother on this statement and will not go on.

Thanks very much

Rolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

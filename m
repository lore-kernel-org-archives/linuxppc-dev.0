From: "Scott Howard" <scott.howard@windriver.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC8260 boards with Linux support ?
Date: Thu, 31 Aug 2000 09:54:09 -0700
Message-ID: <NDBBKHHMCLNIANLKMPHOGEKPCDAA.scott.howard@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <39ADDF77.8080608@ctam.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Monta Vista has the 2.4.0 kernel running on EST's SBC8260 board.

Monta Vista's documentation says that you need their ROM monitor (I think
it's called RMON) programmed into the board's flash memory in order to boot
Linux, but we were able to get it running under EST's monitor (visionWare)
with the help of about 20 lines of assembly code.

Scott

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Brendan
Simon
Sent: Wednesday, August 30, 2000 9:31 PM
To: linuxppc-embedded
Subject: MPC8260 boards with Linux support ?



Can anyone suggest an 8260 development board that is supported by the
Linux/PPC kernels.
Does the 2.2.X series support 8260 or would I have to go to the 2.3.X or
2.4 series ?

Thanks,
Brendan Simon.

PS. Please CC me directly as well as to the list.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

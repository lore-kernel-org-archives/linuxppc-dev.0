Message-ID: <FA06AA2C99BCD511951200005A9944103FB1C4@irvexch1.sextantifs.com>
From: "Weber, Robert" <Robert.Weber@Thales-IFS.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 22 Oct 2002 15:31:37 -0700
Subject: Lockup problem with I2C bus
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_15_25_09_Tuesday_October_22_2002_8073"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

----=_NextPart_ST_15_25_09_Tuesday_October_22_2002_8073
Content-Type: text/plain;
	charset="iso-8859-1"

Hello. I'm running the 2.4.2 (monta vista 2.0) linux kernel on a custom 8260
board. When using the i2c driver that's built into the kernel, things
generally work fine, but sometimes the bus locks up. I suspect there could
be 2 issues.

1. There is no timeout in the driver, so when the master is waiting for a
response but the slave doesn't seem to think it should provide one (maybe
the msg was corrupted), the master can wait indefinitely. It'd be nice to
timeout the transmission and have the master try again.

2. If the master and slave get out of sync, the slave device can hold the
sdata line. Is there a way to get the kernel to produce some clock signals
to try and get the slave to finish whatever it thinks it should be doing,
and get control of the bus back to the master? There's no way to reset the
slaves (an LM75, LM83 and a custom control board) without resetting the
entire unit. Admittedly, this should happen, but when a script that uses the
i2c bus is terminated uncleanly, we've had it occur. It'd be nice if there
was a way to recover.

Thanks in advance.

-  Bob Weber
   Thales Avionics In-Flight Systems
   email: robert.weber@thales-ifs.com


----=_NextPart_ST_15_25_09_Tuesday_October_22_2002_8073
Content-Type: image/gif;
	name="Tech Tools.gif"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="Tech Tools.gif"
Content-ID: <610592222@22102002-0de8>

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
qM7QtIUFamLsY9eaCHV1bZmnfOc732sEBAA7

----=_NextPart_ST_15_25_09_Tuesday_October_22_2002_8073--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <0F48024310E5D6118D200002B3A440DB08B079E4@zil01exm08.mcil.comm.mot.com>
From: Meriin Michael-BMM063 <BMM063@motorola.com>
To: "Linuxppc-Dev (E-mail)" <linuxppc-dev@lists.linuxppc.org>
Subject: Using SMC patch on MPC852T
Date: Tue, 11 May 2004 16:27:50 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

I am trying to apply a SMC patch (exit0.1 MPC8XX SMC(UART) and I2C/SPI MICROCODE PACKAGE).
MPC852T does not have SCC1&2, but SMC1 is overlapped with SCC3.
In our implementation we need both portsSMC1 (console) and SCC3 (Ethernet).
The first thing I tried was to eliminate places in enet.c code which are using SMC1 area, but SCC3 was not transmitting.
Now I've applied patch as it described in the manual (using micropatch.c). After enabling Tx and Rx in SMC1, it starts transmitting by it self.
Any ideas?
Does somebody use SCC3 & SMC1 together without patch?



Best Regards,
     Michael Meriin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

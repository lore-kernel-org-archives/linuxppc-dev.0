From: Cha Hyun Joon <tachyon@postech.ac.kr>
Message-Id: <200012041751.CAA03877@vision.postech.ac.kr>
Subject: [i2c] Do I need ucode relocation patch?
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 5 Dec 2000 02:51:30 +0900 (KST)
MIME-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

I'm running Montavista hardhat Linux kernel-2.2.14 with my custom board.

Since there is video decoder board which is connected by I2C bus with MPC860SAR on board, I have to adopt i2c device driver of Kim Jorgensen and my first attempt to write a value to i2c bus makes Linux hang.

There are many posting of I2C and SCC1 conflict, so I've searched 860 errata from Motorola web site. But my 860 is not listed anywhere on it.

The version number of MPC860SAR is "XPC860SRZP50D3 , QQFV00261 , 2K20A".
I'm using SCC1 as ethernet and SMC1 as ttyS0.

Do I need ucode relocation patch to work with i2c bus?

Thanks in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <zhonglei@RCS-9000.COM>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id D934B68263
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2005 17:07:18 +1000 (EST)
Date: Thu, 15 Sep 2005 15:10:10 +0800
Message-Id: <200509151510.AA26476646@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <linuxppc-dev@ozlabs.org>
Subject: MPC5200 BestComm
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi:  
  My BestComm driver encounter the TEA.Please give 
me a help! 
  The register values are as follows: 
/**********************************************/ 
Setting BestComm Interface to the Local Plus 
Bus......Set GR=001 
starts DMA when 0x000001f3 bytes! 
[ OK ] 
MPC5xxx_MBAR+0x3C04 is 0x00000140 
MPC5xxx_MBAR+0x3C08 is 0x03010002 
MPC5xxx_MBAR+0x3C0C is 0x00000101 
MPC5xxx_MBAR+0x3C48 is 0x01000000 
MPC5xxx_MBAR+0x3C4C is 0x000001F3 
MPC5xxx_MBAR+0x3C00 is 0x00000010 
Starting BestComm setting...... 
TaskSetup......[ OK ] 
LPRDTaskId=0x00000004 
BestComm request_irq 
succeed!MPC5xxx_SDMA_IRQ_BASE+LPRDTaskId=0x00000019 
TaskStart running ......[ OK ] 
htm_open: LPRDTaskId task 4 started 
Kick off FIFO! 
irq is entered! 
TaskIntStatus=0xFFFFFFFF 
End of irq! 
MPC5xxx_MBAR+0x1F64 is 0x00000007 
MPC5xxx_MBAR+0x1F68 is 0x00007121     // this is 
the priority setting 
MPC5xxx_MBAR+0x0500 is 0x0AFFFD00 
MPC5xxx_MBAR+0x0504 is 0x00000000 
MPC5xxx_MBAR+0x0508 is 0x00000000 
MPC5xxx_MBAR+0x050C is 0x00000000 
MPC5xxx_MBAR+0x0510 is 0x00D01001 
MPC5xxx_MBAR+0x0514 is 0x00010FFF 
MPC5xxx_MBAR+0x0518 is 0x00000000 
MPC5xxx_MBAR+0x051C is 0x00000000 
MPC5xxx_MBAR+0x0524 is 0x00000001 
MPC5xxx_MBAR+0x0528 is 0x00000000 
MPC5xxx_MBAR+0x052C is 0x00002000 
MPC5xxx_MBAR+0x0530 is 0x00800000 
MPC5xxx_MBAR+0x0538 is 0x00000000 
MPC5xxx_MBAR+0x3C44 is 0x00020000 
MPC5xxx_MBAR+0x3C48 is 0x01000000 
MPC5xxx_MBAR+0x3C4C is 0x000001F3 
MPC5xxx_MBAR+0x3C50 is 0x00000008  // readptr is 
correct (I set bestcomm transfer 8 bytes from fifo 
LPTaskParam.Size.NumBytes = 8;) 
MPC5xxx_MBAR+0x3C54 is 0x00000010  // writeptr is 
correct 
MPC5xxx_MBAR+0x3C14 is 0x01000010  // bytedone is 
correct 
MPC5xxx_MBAR+0x1218 is 0xFFFFFFE3 
MPC5xxx_MBAR+0x1214 is 0x14000000  // a TEA on 
task 4 happens!!! 
MPC5xxx_MBAR+0x1210 is 0x0F0F0001 
MPC5xxx_MBAR+0x121C is 0x03002000 
MPC5xxx_MBAR+0x1220 is 0x20C2C3C3 
MPC5xxx_MBAR+0x1224 is 0x204400C5 
MPC5xxx_MBAR+0x1228 is 0x00000000 
MPC5xxx_MBAR+0x122C is 0x00000000 
MPC5xxx_MBAR+0x1230 is 0x00000000 
MPC5xxx_MBAR+0x1234 is 0x00000000 
MPC5xxx_MBAR+0x1238 is 0x00000000 
MPC5xxx_MBAR+0x123C is 0x07000006 
MPC5xxx_MBAR+0x1240 is 0x05000000 
MPC5xxx_MBAR+0x1244 is 0x00000000 
MPC5xxx_MBAR+0x1248 is 0x00000000 
MPC5xxx_MBAR+0x124C is 0x07000000 
MPC5xxx_MBAR+0x1250 is 0x00000000 
MPC5xxx_MBAR+0x1254 is 0x00000000 
MPC5xxx_MBAR+0x1258 is 0x00000000 
MPC5xxx_MBAR+0x1F48 is 0x00000103  // data tenure 
time-out and address tenure time-out 
MPC5xxx_MBAR+0x1F58 is 0x0FFFFFFF 
MPC5xxx_MBAR+0x1F5C is 0x0FFFFFFF 
MPC5xxx_MBAR+0x1F50 is 0xC1C24CC0  // captured 
address 
MPC5xxx_MBAR+0x1F54 is 0x00000062  // captured 
signal 
/**********************************************/ 
Please give me a help!!!! 
Thanks a lot! 
BestRegards 
zhonglei 

Return-Path: <sudheer_sanna@yahoo.com>
Received: from web41708.mail.yahoo.com (web41708.mail.yahoo.com
	[66.218.93.125]) by ozlabs.org (Postfix) with SMTP id 5E89A67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 07:44:37 +1100 (EST)
Message-ID: <20050323203754.86736.qmail@web41708.mail.yahoo.com>
Date: Wed, 23 Mar 2005 12:37:54 -0800 (PST)
From: jagadeesh reddy <sudheer_sanna@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-294513614-1111610274=:86607"
Subject: Kernel panic: Attempted to kill init!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-294513614-1111610274=:86607
Content-Type: text/plain; charset=us-ascii

Hi Linuxppc-embedded , 

Iam trying to run powerpc linux on xilinx ML310 FPGA board, everything is fine..am using montavista preview kit and recently I have added gigabyte ethernet driver(XGemac) to the kernel and when I try to run new image on target I get following error. My experience is not sufficient enough to predict why such error is happened. 

XGemac: Device instance 0 found 
Instruction machine check in kernel mode. 
Oops: machine check, sig: 7 
NIP: C00D0D58 XER: 20000000 LR: C00D0D4C SP: C0335F20 REGS: c0335e70 
TRAP: 0200 Not tainted 
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 
TASK = c0334000[1] 'swapper' Last syscall: 120 
last math 00000000 last altivec 00000000 
GPR00: 0000000A C0335F20 C0334000 00000006 00000170 C9011100 C08E0B0C 
C9011000 
GPR08: 11111111 C900F000 00000000 00000006 44000042 00000000 00000000 00000000 
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
GPR24: 00000000 00000000 00000000 C01636E4 C08E0960 00000000 C0180000 C08E0A08 
Call backtrace: 
C00D0D4C C00D0960 C0175904 C0175C84 C016C634 C000244C C0006C9C 
Kernel panic: Attempted to kill init! 
<0>Rebooting in 180 seconds.. 

what does " Oops: machine check, sig: 7 " mean .does any one worked with xilinx gigabyte ethernet. thanks a lot...... 

jaggu

		
---------------------------------
Do you Yahoo!?
 Yahoo! Small Business - Try our new resources site! 
--0-294513614-1111610274=:86607
Content-Type: text/html; charset=us-ascii

<DIV><SPAN class=postbody>Hi Linuxppc-embedded&nbsp;, </SPAN></DIV>
<DIV><SPAN class=postbody><BR>Iam trying to run powerpc linux on xilinx ML310 FPGA board, everything is fine..am using montavista preview kit and recently I have added gigabyte ethernet driver(XGemac) to the kernel and when I try to run new image on target I get following error. My experience is not sufficient enough to predict why such error is happened. <BR><BR>XGemac: Device instance 0 found <BR>Instruction machine check in kernel mode. <BR>Oops: machine check, sig: 7 <BR>NIP: C00D0D58 XER: 20000000 LR: C00D0D4C SP: C0335F20 REGS: c0335e70 <BR>TRAP: 0200 Not tainted <BR>MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 <BR>TASK = c0334000[1] 'swapper' Last syscall: 120 <BR>last math 00000000 last altivec 00000000 <BR>GPR00: 0000000A C0335F20 C0334000 00000006 00000170 C9011100 C08E0B0C <BR>C9011000 <BR>GPR08: 11111111 C900F000 00000000 00000006 44000042 00000000 00000000 00000000 <BR>GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 <BR>GPR24: 00000000
 00000000 00000000 C01636E4 C08E0960 00000000 C0180000 C08E0A08 <BR>Call backtrace: <BR>C00D0D4C C00D0960 C0175904 C0175C84 C016C634 C000244C C0006C9C <BR>Kernel panic: Attempted to kill init! <BR>&lt;0&gt;Rebooting in 180 seconds.. <BR><BR>what does " Oops: machine check, sig: 7 " mean .does any one worked with xilinx gigabyte ethernet. thanks a lot...... <BR><BR>jaggu</SPAN></DIV><p>
		<hr size=1>Do you Yahoo!?<br> 
Yahoo! Small Business - <a href="http://us.rd.yahoo.com/evt=31637/*http://smallbusiness.yahoo.com/resources/">Try our new resources site!</a> 
--0-294513614-1111610274=:86607--

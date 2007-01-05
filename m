Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id C5BCCDDE06
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Jan 2007 02:20:29 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2364060ugf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 05 Jan 2007 07:20:28 -0800 (PST)
Message-ID: <45a1b53e0701050720w3e8118aan2edb280ec61c7d5f@mail.gmail.com>
Date: Fri, 5 Jan 2007 09:20:28 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: System Ace booting (or not) question
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_29682_25051723.1168010428515"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_29682_25051723.1168010428515
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  I'm very new to System Ace, and this is probably a stupid question.

  We were able, with the Monta Vista Linux to get a system.ace with a
zImage.elf linux file to boot on an ml403 board.  The system ace chip seemed
to copy the zImage.elf into DDR ram, and the system booted.  No block ram
used.

   We created a board with an xf60 and a system ace chip on it and created a
system.ace file.  The xilinx loads, but the zImage.elf does not copy into
ddr ram.  We ran the testfatfs code and read from and wrote to the compact
flash on the system ace chip, verifying the files through a compact flash
adaptor on a pc.

   We created a memory test using the ppc and were able (after some wiring
changes and other headaches) to prove the ddr ram works.  There is enough of
it to support linux (64 meg), and testing all 64 million locations with
various fixed and incrementing patterns proves it works.

   However, we could not get the external ram to load up with the linux
zImage.elf file. When this failed, we created a system.ace file with two
elf's in it, one for linux, one for a memory read/write tester in block ram.


  It appears the system ace chip loads the info into block ram just fine,
and our memory test executes.  However, our ddr ram has nothing in it.  We
reversed the order of the elf files, and that still did not help.

  Do we need a helper CPLD on this board to accomplish what the ML403
accomplishes?  Or do we need to do a boot loader in code?  If we need to do
a boot loader, how come the Monta Vista linux doesn't need one on the ml403
board?  I've been googling and scouring the Xilinx site, but I've achieved
nothing but a few less hairs on my head.

  I've already asked Monta Vista this question, and they quoted verbatim the
page from the xilinx manual, which is a generic answer to the specific
question.  Even if the xilinx manual is the answer, we aren't seeing the
results the manual implies we will see.

  Can someone give me a clue?

thanks,
wade

------=_Part_29682_25051723.1168010428515
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>&nbsp; I&#39;m very new to System Ace, and this is probably a stupid question.<br><br>&nbsp; We were able, with the Monta Vista Linux to get a system.ace with a zImage.elf linux file to boot on an ml403 board.&nbsp; The system ace chip seemed to copy the 
zImage.elf into DDR ram, and the system booted.&nbsp; No block ram used.<br><br>&nbsp;&nbsp; We created a board with an xf60 and a system ace chip on it and created a system.ace file.&nbsp; The xilinx loads, but the zImage.elf does not copy into ddr ram.&nbsp; We ran the testfatfs code and read from and wrote to the compact flash on the system ace chip, verifying the files through a compact flash adaptor on a pc.
<br><br>&nbsp;&nbsp; We created a memory test using the ppc and were able (after some wiring changes and other headaches) to prove the ddr ram works.&nbsp; There is enough of it to support linux (64 meg), and testing all 64 million locations with various fixed and incrementing patterns proves it works.
<br><br>&nbsp;&nbsp; However, we could not get the external ram to load up with the linux zImage.elf file. When this failed, we created a system.ace file with two elf&#39;s in it, one for linux, one for a memory read/write tester in block ram. 
<br><br>&nbsp; It appears the system ace chip loads the info into block ram just fine, and our memory test executes.&nbsp; However, our ddr ram has nothing in it.&nbsp; We reversed the order of the elf files, and that still did not help.
<br><br>&nbsp; Do we need a helper CPLD on this board to accomplish what the ML403 accomplishes?&nbsp; Or do we need to do a boot loader in code?&nbsp; If we need to do a boot loader, how come the Monta Vista linux doesn&#39;t need one on the ml403 board?&nbsp; I&#39;ve been googling and scouring the Xilinx site, but I&#39;ve achieved nothing but a few less hairs on my head.
<br><br>&nbsp; I&#39;ve already asked Monta Vista this question, and they quoted verbatim the page from the xilinx manual, which is a generic answer to the specific question.&nbsp; Even if the xilinx manual is the answer, we aren&#39;t seeing the results the manual implies we will see.
<br><br>&nbsp; Can someone give me a clue?<br><br>thanks,<br>wade<br><br>

------=_Part_29682_25051723.1168010428515--

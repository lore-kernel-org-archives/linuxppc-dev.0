Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id BE37A67BBC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 23:51:28 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1621025ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 06:51:26 -0700 (PDT)
Message-ID: <45a1b53e0608210651s4f5de382w77e092463dbbf5b7@mail.gmail.com>
Date: Mon, 21 Aug 2006 08:51:22 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: PPC beginner questions
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_37416_21864175.1156168282055"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_37416_21864175.1156168282055
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  I'm new to the PPC and I have a few questions.  I have written a  driver
in the past for the X86 family, using i/o ports, but it was kernel 2.0 and
i/o ports are not mmu handled.
  I've been looking through the archive and I am slowly growing more
confused.

  We are using Xilinx with PPC built in.

   The PPC has a memory management unit.  All of the IP we've added is
mapped to physical addresses.

   1. Can I access the memory the peripherasl are mapped to directly within
the driver without going through functions?
       if NOT, then Do I use
          1. ioremap(),
          2. request_mem_region(),
          3. request_region()
          4. something else?

   2.  Are there any gotcha's with the ppc 405 that Xilinx uses that I
should know about?


thanks,
wade

------=_Part_37416_21864175.1156168282055
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>&nbsp; I'm new to the PPC and I have a few questions.&nbsp; I have written a&nbsp; driver in the past for the X86 family, using i/o ports, but it was kernel 2.0 and i/o ports are not mmu handled.<br>&nbsp; I've been looking through the archive and I am slowly growing more confused.
<br><br>&nbsp; We are using Xilinx with PPC built in.<br><br>&nbsp;&nbsp; The PPC has a memory management unit.&nbsp; All of the IP we've added is mapped to physical addresses.<br><br>&nbsp;&nbsp; 1. Can I access the memory the peripherasl are mapped to directly within the driver without going through functions? 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if NOT, then Do I use <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. ioremap(), <br>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; 2. request_mem_region(), <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. request_region()<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 4. something else?<br><br>&nbsp;&nbsp; 2.&nbsp; Are there any gotcha's with the ppc 405 that Xilinx uses that I should know about?
<br><br><br>thanks,<br>wade<br><br>&nbsp;<br>

------=_Part_37416_21864175.1156168282055--

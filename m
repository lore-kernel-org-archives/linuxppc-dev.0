Return-Path: <blofeldus@yahoo.com>
Received: from web53507.mail.re2.yahoo.com (web53507.mail.re2.yahoo.com
	[206.190.37.68]) by ozlabs.org (Postfix) with SMTP id 1C57ADDD04
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Dec 2007 05:48:03 +1100 (EST)
Date: Fri, 7 Dec 2007 10:41:22 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: Help with MPC5200 + Bestcomm + Local Plus Bus.... same problem
	[ifm ScanMail: oK]
To: jan_baldauf@ifm-electronic.com, linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <515850.1420.qm@web53507.mail.re2.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

---- Original Message ----

From: "jan_baldauf@ifm-electronic.com" <jan_baldauf@ifm-electronic.com>

To: linuxppc-embedded@ozlabs.org

Sent: Friday, December 7, 2007 4:58:56 AM

Subject: Help with MPC5200 + Bestcomm + Local Plus Bus.... same problem [ifm ScanMail: oK] 



  

Hello Roger, 

 

i have read your message. I have now the same problem. I use a CPLD on the Local Plus Bus. The CPLD generates interrupts for the MPC5200B processor. Because of the quick signals, i want to use the Bestcomm unit, to push the Data ( 3 x 16 bit register) directly into the memory. I use the same Kernel. It would be nice, if you could help me, to program a linux driver for that. Or maybe you have any examples. So looking forward for you reply. Thanks a lot for your time. 

 

best regards Jan Baldauf


------




Jan,

 I never did get my FPGA driver working with the bestcomm unit. I ended up doing a half-baked version where I would program the lpc to transfer the data into the FIFO and generate an interrupt when it finished. I could then copy the data quickly from the FIFO to memory (The FIFO interface is wider and faster than my FPGA, so I do reduce processor loading somewhat over directly reading the FPGA) That works OK for small data transfers, but is not optimal.



 In the current mainline there is support for a "gen_bd" bestcomm task which I presume is to be used for the purpose you imply. Perhaps somebody has an example of using that?





good luck!

-rb









      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping

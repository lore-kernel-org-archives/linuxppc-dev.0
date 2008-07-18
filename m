Return-Path: <nareshgbhat@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 754E7DE07D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 21:13:16 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so101687yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 04:13:15 -0700 (PDT)
Message-ID: <cf9b3c760807180413w447535a7h35d8ce15c2c8e4e@mail.gmail.com>
Date: Fri, 18 Jul 2008 16:43:14 +0530
From: "Naresh Bhat" <nareshgbhat@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: ml403_emb_ref_ppc_81.zip problem
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_34682_9509472.1216379594433"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_34682_9509472.1216379594433
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

My problem is explained here...

While creating the new XPS project using Base system Builder:


Step 1.



New Project->Base System builder Project-> Create a new XPS project using
Base system Builder->Browse system.xps project from "ml403_emb_ref_ppc_81"
directory and overite it.



Step 2.

I am selecting "I would like to create the new design"

and then

Board Vendor "Xilinx"

Board name "ML403"

Board version "1"



Step 3:

I just click "Next"



Step 4:

I am selecting the Processor Cloclk Frequency as "300Mhz"



Step 5: Configuring the IO interfaces



Here is my problem.



In RS232 UART I am having the only 2 option

1. XPS_UARTLITE

2. XPS_UART16550



If I use the same base system builder (ml403_emb_ref_ppc_81) with other
version of the EDK tools (like 8.1iSP2, 9.2iSP2). and repeat the same steps
I am able to see the options like

1. OPB_UARTLITE

2. OPB_UART16550

3. PLB_UART16550



Do you have any idea on this Why it is not getting displayed on the
EDK10.1iSP2 version?


Thanks

Naresh Bhat

------=_Part_34682_9509472.1216379594433
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><p>My problem is explained here...</p><br><p>While creating the new XPS project using Base system Builder:</p><p><br></p><p>Step 1.</p><p>&nbsp;</p><p>New
Project-&gt;Base System builder Project-&gt; Create a new XPS project
using Base system Builder-&gt;Browse system.xps project from
&quot;ml403_emb_ref_ppc_81&quot; directory and overite it.</p><p>&nbsp;</p><p>Step 2.</p><p>I am selecting &quot;I would like to create the new design&quot; </p><p>and then </p><p>Board Vendor &quot;Xilinx&quot; </p><p>Board name &quot;ML403&quot;</p>
<p>Board version &quot;1&quot;</p><p>&nbsp;</p><p>Step 3:</p><p>I just click &quot;Next&quot;</p><p>&nbsp;</p><p>Step 4:</p><p>I am selecting the Processor Cloclk Frequency as &quot;300Mhz&quot;</p><p>&nbsp;</p><p>Step 5: Configuring the IO interfaces</p>
<p>&nbsp;</p><p>Here is my problem. </p><p>&nbsp;</p><p>In RS232 UART I am having the only 2 option</p><p>1. XPS_UARTLITE</p><p>2. XPS_UART16550</p><p>&nbsp;</p><p>If
I use the same base system builder (ml403_emb_ref_ppc_81) with other
version of the EDK tools (like 8.1iSP2, 9.2iSP2). and repeat the same
steps I am able to see the options like</p><p>1. OPB_UARTLITE</p><p>2. OPB_UART16550 </p><p>3. PLB_UART16550</p><p>&nbsp;</p><p>Do you have any idea on this Why it is not getting displayed on the EDK10.1iSP2 version?</p><p><br>
</p><p>Thanks</p><p>Naresh Bhat<br></p></div>

------=_Part_34682_9509472.1216379594433--

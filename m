Return-Path: <barisa.kisku@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id 725B7DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 17:11:52 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so586319nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 01 Nov 2007 23:11:50 -0700 (PDT)
Message-ID: <80bb1bc60711012311v772a509di616e9190d7be391a@mail.gmail.com>
Date: Fri, 2 Nov 2007 11:41:49 +0530
From: "Barisa Kisku" <barisa.kisku@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: what is difference between interrupt context and process context?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2124_31371683.1193983910009"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2124_31371683.1193983910009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

What is difference between interrupt context and process
context.Fromhardware(register context) view
how they are different.In linux-2.6 interrupt stack is separate from kernel
stack.How interrupt stack pointer
is retrieved?How is the implementation in freescale ppc/powerpc.

please comment.

thanks in advance.

Barisa Kisku

------=_Part_2124_31371683.1193983910009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>
<br>
What is difference between interrupt context and process context.From hardware(register context) view <br>
how they are different.In linux-2.6 interrupt stack is separate from kernel stack.How interrupt stack pointer <br>
is retrieved?How is the implementation in freescale ppc/powerpc.<br>
<br>
please comment.<br>
<br>
thanks in advance.<br>
<br>
Barisa Kisku<br>

------=_Part_2124_31371683.1193983910009--

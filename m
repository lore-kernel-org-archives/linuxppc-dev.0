Return-Path: <barisa.kisku@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.233])
	by ozlabs.org (Postfix) with ESMTP id AF207DDF28
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Oct 2007 20:22:20 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so1010300wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Oct 2007 03:22:19 -0700 (PDT)
Message-ID: <80bb1bc60710230322t17fa517bt324031195abced24@mail.gmail.com>
Date: Tue, 23 Oct 2007 15:52:18 +0530
From: "Barisa Kisku" <barisa.kisku@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel function having physical address. how?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_269_4192556.1193134938189"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_269_4192556.1193134938189
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,

I have  ported linux-2.6.20 in cutom board based on MPC860.Kernel with the
KERNELBASE as default 0xc00000000.
uImage is downloaded at some address and booted with "bootm"
command.Kernelis uncompressed and  loaded at
0x00000000.All  the kernel function is now having physical address  (e.g.
0x000020c8 instead of 0xc00020c8, which
is given by compiler).I think this required, to run kernel before MMU is on,
but how  this change in assembled code happens.
Does u-boot do this when uncompressing and loading the kernel. Please
comment.

thanks in advance.

Barisa

------=_Part_269_4192556.1193134938189
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br>
<br>
I have&nbsp; ported linux-2.6.20 in cutom board based on MPC860.Kernel with the KERNELBASE as default 0xc00000000.<br>
uImage is downloaded at some address and booted with &quot;bootm&quot; command.Kernel is uncompressed and&nbsp; loaded at <br>
0x00000000.All&nbsp; the kernel function is now having physical
address&nbsp; (e.g.&nbsp; 0x000020c8 instead of 0xc00020c8, which<br>
is given by compiler).I think this required, to run kernel before MMU
is on, but how&nbsp; this change in assembled code happens.<br>
Does u-boot do this when uncompressing and loading the kernel. Please comment.<br>
<br>
thanks in advance.<br>
<br>
Barisa<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; <br>
<br>

------=_Part_269_4192556.1193134938189--

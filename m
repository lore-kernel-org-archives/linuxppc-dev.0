Return-Path: <mannivelle@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190])
	by ozlabs.org (Postfix) with ESMTP id A9ED4DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Oct 2008 19:06:47 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so2129536mue.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Oct 2008 01:06:44 -0700 (PDT)
Message-ID: <f451b120810280106n3c495202i87878008d4102833@mail.gmail.com>
Date: Tue, 28 Oct 2008 09:06:44 +0100
From: "florent manni" <mannivelle@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: linux automatic logging and automatic script execution
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_84087_14472066.1225181204825"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_84087_14472066.1225181204825
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone,
I'm working on linux (last xilinx git version 2.6.27) on Virtex4 FX12 board
from memec.
I'm using buildroot with uclibc  and busybox to create the cross compiler
and the rootfs (everything set up within one elf file with initrd).

I try to make my embedded linux auto-logging and auto-executing a program
after kernel loads thus I haven't got to use the terminal to logging and
start my embedded program.

does anyone has got a clue where I should look to set this option (I think
it might be around /etc/initrd but I'm not sure).

thanks a lot.

florent

------=_Part_84087_14472066.1225181204825
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone,<br>I&#39;m working on linux (last xilinx git version 2.6.27) on Virtex4 FX12 board from memec.<br>I&#39;m using buildroot with uclibc&nbsp; and busybox to create the cross compiler and the rootfs (everything set up within one elf file with initrd).<br>
<br>I try to make my embedded linux auto-logging and auto-executing a program after kernel loads thus I haven&#39;t got to use the terminal to logging and start my embedded program.<br><br>does anyone has got a clue where I should look to set this option (I think it might be around /etc/initrd but I&#39;m not sure).<br>
<br>thanks a lot.<br><br>florent<br><br>

------=_Part_84087_14472066.1225181204825--

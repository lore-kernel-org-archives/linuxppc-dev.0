Return-Path: <smdelusa@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 40458DDED5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Jul 2007 19:50:52 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2203309wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 02 Jul 2007 02:50:50 -0700 (PDT)
Message-ID: <1a866be30707020250p7145b143j71042c3b115d01c4@mail.gmail.com>
Date: Mon, 2 Jul 2007 18:50:50 +0900
From: "SHIERA LYN DELUSA" <smdelusa@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Linux Process Address Space
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_94874_15145690.1183369850153"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_94874_15145690.1183369850153
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Based on the following thread regarding Linux memory map:
http://ozlabs.org/pipermail/linuxppc-embedded/2000-May/001333.html

Obviously, I am still a newbie in Linux kernel and I find it hard to grasp
things especially Linux MM.  I quoted some lines from this thread (from
Dan's post), then some follow-up questions.  I do hope you could help me out
in these:

1.)  *"Virtual addresses from 0 to 0x7fffffff are for user context."*
     a.) If TASK_SIZE is defined as 0x80000000, does this necessarily mean
that 2G-2G split is used?


2.)  *"For this reason, and since it followed prior PowerPC platform
examples, I chose to map the embedded 8xx kernel to the 0xc0000000 virtual
address."*
     a.)  This 0xc0000000 virtual address must be defined as the value of
PAGE_OFFSET, right?
     b.)  Does this mean that the kernel's .text section is located in this
address?
     c.)  If user space is only up to 0x80000000, and the kernel starts at
0xc0000000, what could possibly be located in between?


3.)  *"Prior to this KVM initialization, we choose to map virtual to
physical addresses 1:1.  That is, the kernel virtual address exactly matches
the physical address on the bus.  These mappings are typically done in
arch/ppc/kernel/head.S, or arch/ppc/mm/init.c.  Only   absolutely necessary
mappings should be done at this time, for example board control registers or
a serial uart.  Normal device driver initialization should map resources
later when necessary." *
      a.)  Is there any chance that the mapping done here is relocated later
in the initialization process?


I would really appreciate your input on this.  Thank you very much!


Regards,
Shiera

------=_Part_94874_15145690.1183369850153
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello,</div>
<div>&nbsp;</div>
<div>Based on the following thread&nbsp;regarding Linux memory map:</div>
<div><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://ozlabs.org/pipermail/linuxppc-embedded/2000-May/001333.html" target="_blank">http://ozlabs.org/pipermail/linuxppc-embedded/2000-May/001333.html</a>
</div>
<div>&nbsp;</div>
<div>Obviously, I am still a newbie in Linux kernel&nbsp;and I find it hard to grasp things especially Linux MM.&nbsp; I quoted some lines from this thread (from Dan&#39;s post), then&nbsp;some follow-up questions.&nbsp; I do hope you could help me out in these:
</div>
<div>&nbsp;</div>
<div>1.)&nbsp; <em>&quot;Virtual addresses from 0 to 0x7fffffff are for user context.&quot;</em></div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a.) If TASK_SIZE is defined as 0x80000000, does this necessarily mean that 2G-2G split is used?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>2.)&nbsp; <em>&quot;For this reason, and since it followed prior PowerPC platform examples, I chose to map the embedded 8xx kernel to the 0xc0000000 virtual address.&quot;</em></div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a.)&nbsp; This 0xc0000000 virtual address must be defined as the value of PAGE_OFFSET, right?</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b.) &nbsp;Does this mean that the kernel&#39;s .text section is located in this address?</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; c.)&nbsp; If user space is only up to 0x80000000, and the kernel starts at 0xc0000000, what could possibly be located in between?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>3.)&nbsp; <em>&quot;Prior to this KVM&nbsp;initialization, we choose to map virtual to physical addresses&nbsp;1:1.&nbsp; That is, the kernel virtual address exactly matches the&nbsp;physical address on the bus.&nbsp; These mappings are typically done&nbsp;in arch/ppc/kernel/head.S, or arch/ppc/mm/init.c.&nbsp; Only&nbsp;&nbsp; absolutely necessary mappings should be done at this time, for&nbsp;example board control registers or a serial uart.&nbsp; Normal device&nbsp;driver initialization should map resources later when necessary.&quot; 
</em></div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a.)&nbsp; Is there any chance that the mapping done here is relocated later in the initialization process?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><span></span>I would really appreciate your input on this.&nbsp; Thank you very much!</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Regards,</div><span class="sg">
<div>Shiera</div></span>

------=_Part_94874_15145690.1183369850153--

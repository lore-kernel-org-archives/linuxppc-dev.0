Message-ID: <3EF0A99A.8060400@esteem.com>
Date: Wed, 18 Jun 2003 11:04:10 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: zjzhou@newrocktech.com
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Is GCC >= 3.1 available for ELDK ? (or other means to compile
 Ada code)
References: <000501c335bb$b5d94f20$7d395fd3@john>
In-Reply-To: <000501c335bb$b5d94f20$7d395fd3@john>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Zhou wrote:
> Hi,
>
> Does anybody know where I can get the document or manual about PowerPC assembly language ("as") ?
>
> Thanks in advance!
>
> Regards,
> Zhou
>
>
>
>
Hi John,


Here is a good starting point

http://www-106.ibm.com/developerworks/library/l-ppc/?t=gr,lnxw09=PowPC

Here is an IBM PDF file (600+ page book) on PowerPC assembly lang

http://www-3.ibm.com/chips/techlib/techlib.nsf/techdocs/852569B20050FF778525699600719DF2

Here is an IBM PDF compiler writers guide on PPC asm tuning etc.

http://www-3.ibm.com/chips/techlib/techlib.nsf/techdocs/852569B20050FF7785256996007558C6


Here is a good starting point for Linux based asm (mostly x86)
http://linuxassembly.org/


	The most useful thing I can recomend is using these books/guides as a
reference and compiling c source code with the GCC flag  --save-temps to
generate assembly source from c code. This not only gives you a good
idea of what the assembly code is doing, but lets you analyze and refine
your C coding technique and practices to generate the best code.

Good Luck

Conn
--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

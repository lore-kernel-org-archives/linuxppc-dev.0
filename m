Date: 29 Apr 2002 06:59:43 -0000
Message-ID: <20020429065943.29396.qmail@webmail11.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Reply-To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: inflate problem
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi ,

  I am using 8260 processor,montavitsa sources,
i am using limon to download kernel on the board,
when decompressing after certain number of bytes
its not inflateing properly

i saw vmlinux when uncompressed is same upto cetain bytes ,
when jump from head.S to prom_init is not happening

what i did was i placed directly vmlinux into memory and gave
control to it  it jumping to prom_init,its not stack problem
,please give any hint or where i am going wrong
thanks in advance

_________________________________________________________
Click below to visit monsterindia.com and review jobs in India or
Abroad
http://monsterindia.rediff.com/jobs


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

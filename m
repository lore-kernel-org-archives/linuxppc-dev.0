Message-ID: <20030805163657.14967.qmail@web40306.mail.yahoo.com>
Date: Tue, 5 Aug 2003 09:36:57 -0700 (PDT)
From: Miku Jha <jha_miku@yahoo.com>
Subject: using YAMD on powerpc
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have an embedded environment running on linux
power pc.

I was trying to cross compile YAMD for
PowerPc.

Is it possible for me to do so.

If you could provide me some tips on doing this or
porting YAMD for PowerPc it will be really
helpful.

We dont have any tools at present to find out
the memory leaks in our embedded environment.


Right now this is the compilation error I get
In function `startup':
yamd.c:1861: `sigsegv_handler' undeclared (first use
in this function)
yamd.c:1861: (Each undeclared identifier is reported
only once
yamd.c:1861: for each function it appears in.)

Which makes sense since this code is only for
linux x86.

Thanks.

ps:does anybody know of any other memory management
tool for PowerPc .


=====
mailto:jha_miku@yahoo.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <20030312181132.1087.qmail@web41211.mail.yahoo.com>
Date: Wed, 12 Mar 2003 10:11:32 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: User mode accesses cause a SIGSEGV 
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030218014641.49645.qmail@web41201.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Folk,

I have a problem with user mode processes on my PPC405
based board with 16MB SDRAM. I am using busybox based
'init'. When linux boots, init tries to swapn 'sh'.
Shell starts ok but after that, any 'application'
started under 'sh' bails out with error
"User mode accesses cause a SIGSEGV for <some
address>"

The address it bails out is always same and generally
is a huge value (ex: 0x92612077).

I am suspecting that there might be something wrong
with user mode PTEs. I am not sure when PTEs are
created how they are privileged.

Any help is appreciated.

Thanks,
Prakash


Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

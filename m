Message-ID: <406B9D084FAFD4118C980008C79FADB901B57FFD@ALBMAIL>
From: "Yang, Bo" <bo.yang@transcore.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem loading RTAI modules
Date: Thu, 17 Apr 2003 18:44:36 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I try to load RTAI modules on MPC8XXFADS board running DENX's linux-2.4.
I didn't see the messages like "rtai: decrementer frequency ..." to indicate

the rtai modules successfully initialized after I install rtai.o,
rtai_fifos.o, and rtai_sched.o
according to installation instruction.
And then I got "Kernel panic: kernel stack overflow" when I try to load
example rtai modules
(like ex_fastick_1.o).

I exactly followed the RTAI install instruction to patch and build the linux
kernel
on the source tree of version "D2002-09-26" as well as all RTAI modules.

Any ideas?  Thanks in advance for any helps.

Bo Yang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

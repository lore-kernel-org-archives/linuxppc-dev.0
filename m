Date: 25 Sep 2003 11:28:40 -0000
Message-ID: <20030925112840.3137.qmail@webmail17.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
Reply-To: "somshekar chandrashekar kadam" <som_kadam1@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: cpm_handler
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI ,

   I am not on this mailing list i have subscribed to it , ineed
yet to receive the acknowledgement ,

before that i need to solve a problem ,

   once my MPC860 calls rs_8xx_init , once cpm_handler_init is
called
i dont get any of the prints on the console , in kernel
configuration ,
i have choosen only smc2 , where else i need to specify touse SMC2
, please any one can throw some light on this , here are my kernel
messages , please do a cc to this mail ID ,please
Thanks And regards
NEELU
--------------------------------------
  Decrementer Frequency = 187500000/60
Calibrating delay loop... 49.76 BogoMIPS
Memory: 6892k available (808k kernel code, 296k data, 40k init, 0k
highmem)
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
IN init ok
IN do_basic setup
  in SOCK_INIT
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
  before do_initcalls
Starting kswapd
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
state->irq = 4
  ENtering m8xx_cpm_hostalloc
in SMC
  Entering inatll interrupt handler
  Entering m8xx_cpm_setbrg
AFTER CPM SETBRG
ttyS01 at 0x0380 is a SMC
state->irq = 3


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

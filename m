From: jimix@pobox.com (Jimi X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14827.34607.795659.155820@kitch0.watson.ibm.com>
Date: Mon, 16 Oct 2000 18:54:39 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: Boot Rom Version and os-chooser
Reply-To: jimix@watson.ibm.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I updated with Apples PowerBook Firmware Update 2.7 on my pismo as
apple suggested to fix some firewire kinks I had.

Apple System Profiler says:
  ROM revision:			$t7D.45F6
  Boot ROM verion:		$0003.27f2
  Mac OS ROM file version:	3.8


Now my os-chooser forth script does not work.
I tried adding the obvious "PowerBook3,2" to the <COMPATIBLE>

Should I have tried upping the major number?

-Jimi X

BTW: I can boot linux fine (no surprise), I just have to go into OF to
     boot OS9 (pain pain pain).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

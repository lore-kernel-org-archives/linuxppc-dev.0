Message-ID: <8D4C69676E66D511A1CB00508BBBB1922C4173@ranmx1.ran.harris.com>
From: "Kappl, Hannes" <hkappl@harris.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: set a limit for the cache
Date: Fri, 5 Jul 2002 03:38:05 -0400 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi,

 I am using kernel 2.4.4. I have 32M RAM with a 10M Ramdisk. Now my problem is
that
 the Ramdisk is cached in the RAM(4 - 8M!). Is it possible to set the size of
the
 cache to a limit or to disable the cache complete?



   7:13pm  up 34 min,  0 users,  load average: 0.12, 0.33, 0.30
 22 processes: 21 sleeping, 1 running, 0 zombie, 0 stopped
 CPU states:  0.9% user,  4.3% system,  0.0% nice, 94.7% idle
 Mem:   30612K av,   9216K used,  21396K free,   9904K shrd,      0K buff
 Swap:      0K av,      0K used,      0K free                  5392K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
  107 root      14   0   836  836   644 R       0  4.5  2.7   0:00 top


 best regard
 Hannes


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3FCEEC38.4010608@dgt-lab.com.pl>
Date: Thu, 04 Dec 2003 09:11:36 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: cached memory
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


how to change strategy of using cached memory?

this is a shot from top program on my board
==========================================
  7:31pm  up 18:31,  2 users,  load average: 2.46, 1.89, 1.17
28 processes: 25 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  0.1% user, 99.8% system,  0.0% nice,  0.0% idle
Mem:   127888K av,  124880K used,    3008K free,       0K shrd,       0K
buff
Swap:       0K av,       0K used,       0K free                   58936K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  768 root      14   0 10740  500   388 R    96.7  0.3   3:17 dd
  522 root       9   0  1264 1264   932 D     1.1  0.9   0:09 ftp
==========================================

in some cases there are "out of memory" errors in my applications,
esspecialy when system has high load, free memory slowy goes down
there are no new allocs in applications, but cache keeps growing


--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

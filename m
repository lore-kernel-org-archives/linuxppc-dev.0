Message-ID: <E8F83D6D2A6AD3118E0300902786A20502371482@NTEX>
From: "David Marqvar (DAM)" <DAM@tt.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Laurits Lassen Petersen (LLP)" <LLP@tt.dk>
Subject: Memory-usage
Date: Thu, 2 May 2002 21:29:43 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello world!

How do I check the memory-usade on the embedded system?

I have been using "free" and "cat /proc/meminfo"

Is there another way to get more precise information on the memory-usage?
It says: MemTotal: 3056 kB --- can you confirm that this means that the
kernel is using 4096 - 3056 = 1040 kB (There is 4 MB total ram on the
system).

Regards,
David Marqvar


# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:   3129344  2621440   507904   663552   729088   688128
Swap:        0        0        0
MemTotal:         3056 kB
MemFree:           496 kB
MemShared:         648 kB
Buffers:           712 kB
Cached:            672 kB
Active:            704 kB
Inact_dirty:       680 kB
Inact_clean:         0 kB
Inact_target:        4 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         3056 kB
LowFree:           496 kB
SwapTotal:           0 kB
SwapFree:            0 kB
# free
              total         used         free       shared      buffers
  Mem:         3056         2540          516          628          712
 Swap:            0            0            0
Total:         3056         2540          516

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

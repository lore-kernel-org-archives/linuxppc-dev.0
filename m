Message-ID: <39E3915B.528A90FF@emc.com>
Date: Tue, 10 Oct 2000 17:59:55 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: exchanges file in minicom
References: <Pine.HPX.4.10.10010102202210.16113-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I boot linux over IDE disk.
The only connection between host and target is RS232 which is used
to download and as console(minicom).

After kernel is running on target, how can I send/receive files between
host(minicom/linux) and target ?

For ascii file, I can use "cat  < /dev/ttyS0" on target, and
"ascii-xfr .." on host. How about Binary files ?

Thanks,
--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

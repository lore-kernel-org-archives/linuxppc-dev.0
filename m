From: szg98@mail.zhongxing.com
To: raphael.bossek@solutions4linux.de
cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <48256874.003CDBD5.00@mail.zhongxing.com>
Date: Fri, 28 Jan 2000 19:13:34 +0800
Subject: Re: Cachable / Non-cachable memory
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>






In arch/ppc/mm/init.c,
the mpc8xx-linux code use map_page(v,p,flags),
to set one memory page to some properities,like _NO_CACHE_PAGE,etc.





raphael.bossek@solutions4linux.de 在 2000-01-28 17:31:23

收件人:   linuxppc-embedded@lists.linuxppc.org
抄送：     （密送：单正光/硬一/上海第二研究所/zte_ltd)
主题：    Cachable / Non-cachable memory





Hi,

how does Linux specify memory regions as cachable and non-
cachable? It is sometimes required to mark mapped memory
regions from devices as non-cachable by the MMU so the PowerPC
does not tune the write/read accesses.

Is there any function or sample driver code in the mpc8xx-linux
2.2.13 code ?

cu Raphael Bossek - http://www.solutions4linux.de/powerpc.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

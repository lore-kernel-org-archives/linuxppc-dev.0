MIME-Version: 1.0
Message-Id: <38EDBA6F.06842@mta2>
Date: Fri, 7 Apr 2000 18:37:35 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: about memory bandwidth
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi,How to measure the 60x bus bandwidth.I write a program to write
to sdram in a tight loop,every iteration ,i write 8 words,
it takes about 36 seconds to finish 32M iterations with i-cache
enabled and d-cache disenabled.With d-cache enabled and flushing
 cache in every iteration,it takes about 16 seconds.This is below
what i speculated.What is the possible reason?I program the sdram
machine to enable burst mode.                            4/7/2000

_____________________________________________
263首都在线--中国人的网上家园 http://www.263.net
精彩、免费、还能省上网费，快订阅索易电子刊物！http://www.soim.com
积（优）点，换（奖）品！http://www.thepoints.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

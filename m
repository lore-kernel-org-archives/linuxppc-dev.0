To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 May 2002 15:48:51 +0800."
             <002901c2061c$1d564840$7301a8c0@zhongqx>
Date: Tue, 28 May 2002 10:23:51 +0200
Message-Id: <20020528082356.7495911973@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <002901c2061c$1d564840$7301a8c0@zhongqx> you wrote:
>
>    I use ppcboot to booting linux ,but linux cann't go on when malloc some memory.My board is FADS860T,
> it has 4M DRAM(in physical 0---3fffff) and 4M SDRAM(in physical address is 03000000-033fffff),when ppcboot
> run up,i use bdi command find it tell me total memory is 8M which is from 0 to 7fffff.i think ppcboot maped
> two memory block into one continuous memory block(are i right?).when ppcboot boot linux it pass bdi to linux,
> so i don't know whether linux kernel  understand the memory 0---7fffff is actualy  two memory block which
> is 0----3fffff and 03000000 -033fffff.who can tell me how to understand this.sorry for my bad english.thank

The Linux boot messages contain information about how much memory  it
found; search for a line like this:

...
Memory: 62604k available (1164k kernel code, 540k data, 52k init, 0k highmem)
...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are three principal ways to lose money: wine, women, and engi-
neers. While the first two are more pleasant, the third is by far the
more certain."                           - Baron Rothschild, ca. 1800

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

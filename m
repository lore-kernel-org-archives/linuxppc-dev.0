Date: Tue, 17 Sep 2002 15:02:04 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: Ricardo Scop <scop@plugin.com.br>
Message-ID: <11626.020917@plugin.com.br>
To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why FEC and SCC1 can not work at the same time?
In-reply-To: <001001c25e1e$c9c33ac0$7301a8c0@zhongqx>
References: <001001c25e1e$c9c33ac0$7301a8c0@zhongqx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zhongqx,

Probably there some is initialization missing/misconfigured both in FEC
and SCC enet drivers for your board. Main candidates are I/O pins
configuration and/or clock selection.

HTH,

Ricardo Scop                            mailto:scop@digitel.com.br

------------------------------------------------------------------
It might look like I'm doing nothing, but at the cellular level I'm
really quite busy.

Tuesday, September 17, 2002, 4:49:44 AM, you wrote:


z> Hello,every one
z>     Hello Wolf gang thank you for help!my ramdisk problem has passed!I use linux-2.4.4-2002-02-14 kernel and all is ok!but I dont understand why linux-2.4.18 is not ok.


z> Now I meet a new problem! it is very strange!
z> I want to use FEC(100M) and SCC1(10M) interface,but they can not work together.
z>      When I use ppcboot with CONFIG_SCC1_ENET defined , boot linux ,then SCC1 is ok,when I ping FEC (I config it ip address is 192.168.2.221) it displayed messaged "time out".
z>      When I use ppcboot with CONFIG_FEC_ENET  defined,  boot linux ,then FEC is ok, when I
z> ping SCC( I config it ip address is 192.168.1.198) it displayed messaged also "time out".

z> Can you someone give help?thank you in advanced! the following is the linux output:

<snip>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 20 Mar 2002 09:11:10 PST."
             <0203201711.AA10183@ivan.Harhan.ORG>
Date: Wed, 20 Mar 2002 19:06:07 +0100
Message-Id: <20020320180612.D8AAF109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <0203201711.AA10183@ivan.Harhan.ORG> you wrote:
>
> Just what is wrong with my solution of BI_GT64260_ETH_CFG, BI_8260_ETH_CFG,
> BI_8XX_ETH_CFG, etc?

I don't think you need to pass different information around; in fact,
all these probably need exactly the same information... There  is  no
inherent  difference between the ethernet interfaces on a 8xx or on a
82xx. But both the 8xx and 82xx come with two pretty  much  different
onchip ethernet controllers (SCC/FEC on 8xx, SCC/FCC on 82xx).

So   should   we   have    BI_8XX_SCC_ETH_CFG,    BI_8XX_FCC_ETH_CFG,
BI_8260_SCC_ETH_CFG, BI_8260_FCC_ETH_CFG, ...? Certainly not.

I don't  know  the  GT64260  that  well;  what  makes  it's  ethernet
interface  so  much  different  from all other devices that it cannot
share a common BI_ETH_CFG?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The question of whether a computer can think is no more  interesting
than the question of whether a submarine can swim"
- Edsgar W.  Dijkstra

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

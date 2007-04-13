Return-Path: <david.lang@digitalinsight.com>
Received: from warden.diginsite.com (warden-p.diginsite.com [208.29.163.248])
	by ozlabs.org (Postfix) with SMTP id B8238DDF12
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 12:55:53 +1000 (EST)
Date: Thu, 12 Apr 2007 19:24:29 -0700 (PDT)
From: David Lang <david.lang@digitalinsight.com>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <Pine.LNX.4.64.0704122243280.9866@mtl.rackplans.net>
Message-ID: <Pine.LNX.4.63.0704121917260.29621@qynat.qvtvafvgr.pbz>
References: <1175644642.10567.31.camel@shinybook.infradead.org><200704032210
	02.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org><20070403.181645.6815945
	8.davem@davemloft.net>
	<20070404022828.5c9b97f3@the-village.bc.nu><Pine.LNX.4.64.0704032307001.780
	2@mtl.rackplans.net>
	<m3tzvm6fgw.fsf@ursa.amorsen.dk><adabqhtip2n.fsf@cisco.com>
	<Pine.LNX.4.64.0704122243280.9866@mtl.rackplans.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Benny Amorsen <benny+usenet@amorsen.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 12 Apr 2007, Gerhard Mack wrote:

> Sometimes it's not the speed it's the cost.. The best I've ever done is
> 5.5 interfaces per u/ Although with a better motherboard and case it might
> have been different.

I have a bunch of servers from rackable, dual core cpu, 2G ram 2xgigE on the 
motherboard (1x100M on motherboard), 4x Intel E1000 quad port cards, 120G SATA 
drive, DVD burner, floppy

3u, 18 gig ports, just under $5k

if you have 36" deep racks you can put them back to back and have two of these 
in 3u (12 gig ports per u)

not nessasarily the cheapest available, but they've been reliable, and there's 
pleanty of CPU and ram to handle firewall tasks.

besides, sometimes you don't want to trust the closed-source vlan 
implementations on the switches ;-)

David Lang

> http://innerfire.net/pics/projects/21portfirewall_2.jpg
> (assigns each port it's ip range and blocks any address not assigned to
> that port)
>
>
> On Thu, 12 Apr 2007, Roland Dreier wrote:
>
>> Date: Thu, 12 Apr 2007 08:34:40 -0700
>> From: Roland Dreier <rdreier@cisco.com>
>> To: Benny Amorsen <benny+usenet@amorsen.dk>
>> Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
>>
>> > Indeed, port density is disappointingly poor in modern servers. Do you
>> > know any with more than 14 ports per U? (That's an MBX 1U server with
>> > 8 on-board and a 6-port expansion).
>>
>> If you really need a ton of ports you could probably build a 1U server
>> with 2 * 2-port 10gig NICs, and use VLAN-capable switches with 10gig
>> and 1gig ports to fan out each 10gig link from your server to 10 1-gig
>> ports.  That would get you 40 ports of 1-gig from each server (plus
>> whatever the server has on board).
>>
>>  - R.
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
> --
> Gerhard Mack
>
> gmack@innerfire.net
>
> <>< As a computer I find your faith in technology amusing.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

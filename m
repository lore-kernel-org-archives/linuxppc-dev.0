To: ppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ethernet on 8260 
In-Reply-To: Message from Brad Bonkoski <bradb59@home.com>
   of "16 Jul 2001 22:30:24 MST." <20010717053606.PQKG23117.femail17.sdc1.sfba.home.com@cx263713-b.mesa1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jul 2001 19:09:34 +1000
Message-ID: <5065.995360974@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 16 Jul 2001 22:30:24 -0700, Brad Bonkoski <bradb59@home.com> writes:
>Does Linux _really_ do this?  Shouldn't it route at the host layer
>before the network layer?

I think it does look for host routes before matching network routes, but
there needs to be one in your routing table. I believe when you configure
the interface the driver installs the network route only. i.e. by default
they will clash.

>Like it I ping 192.168.0.1 it should return
>the ping on that interface regardless of if another network device lives
>on this network!  Or, do I have to explicitly set up host routes in the
>routing table?

Yes, I believe you need to explicitly add them to the routing tables.

>I guess what is the point of having multiple interfaces
>on one board live on the same network, but even so, I would still think
>it should choose the host route before the network route.  Any thoughts
>on this?

You are correct, but you have to set it up manually. Or maybe it depends on
what net-tools package you use - the one I use doesn't add the host routes.

>This is a good idea, but I would like to keep it simple, as they say
>simplicity is the 'key' to High availability.

What could be more simple than removing all that really complicated IP
protocol overhead? :-) Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

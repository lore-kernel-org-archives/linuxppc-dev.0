Mime-Version: 1.0
Message-Id: <v04220801b54ab29142c2@[10.0.0.42]>
In-Reply-To: <20000519050921.14887.qmail@www0i.netaddress.usa.net>
References: <20000519050921.14887.qmail@www0i.netaddress.usa.net>
Date: Fri, 19 May 2000 02:00:23 -0700
To: jeramy b smith <ultrapenguin@netscape.net>, "Mike Hudson" <Exoray@isys.ca>,
        <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: BMAC+ & Full Duplex
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:56 AM -0700 5/19/00, jeramy b smith wrote:
>"Mike Hudson" <Exoray@isys.ca> wrote:
>>
>>  Has anyone looked into the problem with a BMAC+ not being able to do
>>   full-duplex 100baseTX?
>
>Wow, I'm glad I bought a laptop and not a server. My 1999 PowerBook does 100tx
>full duplex without any parameter passing of kernel tweaking. It just
>auto-senses what should be and voila!

I'm pretty sure your 1999 PowerBook uses the same BMAC+ Ethernet as
his PowerMac G3.  The auto-sensing feature doesn't work with all
Ethernet hubs/switches, which is why he's having problems and you
aren't.

I have a couple B&W G3s connected to a 5-port 100BaseT switch, and
they successfully autonegotiate full duplex 100BaseT under both MacOS
and Linux.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

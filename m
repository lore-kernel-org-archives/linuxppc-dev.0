Return-Path: <minyard@acm.org>
Received: from rwcrmhc13.comcast.net (rwcrmhc13.comcast.net [204.127.198.39])
	by ozlabs.org (Postfix) with ESMTP id 317D567A5D
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jan 2005 01:45:08 +1100 (EST)
Message-ID: <41F11439.4050303@acm.org>
Date: Fri, 21 Jan 2005 08:39:53 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <41EC29A8.1040703@mvista.com>
	<1106259956.18397.10.camel@gaston>	<41F0449C.5020603@mvista.com>
	<1106265672.5387.14.camel@gaston>	<41F04849.70506@mvista.com>
	<1106266338.18397.21.camel@gaston>
	<Pine.GSO.4.61.0501211013330.1075@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0501211013330.1075@waterleaf.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:

>On Fri, 21 Jan 2005, Benjamin Herrenschmidt wrote:
>  
>
>>On Thu, 2005-01-20 at 17:09 -0700, Mark A. Greer wrote:
>>    
>>
>>>Yes but as I wrote, I don't have time right now.
>>>      
>>>
>> ... which is exactly my rant ... embedded companies never have time
>>to do the right thing...
>>    
>>
>
>Because they have strict (paid for) deadlines, unlike the `we do it for
>fun'-crowd led by Linus ;-)
>  
>
[begin soapbox]

I disagree with this attitude.  I believe there is a balance to be 
struck between doing
things right and meeting deadlines, and I believe the embedded hardware 
companies
are way too far off on the meeting deadlines side of things.  From what 
I can tell, they
tend to be penny-wise and pound-foolish.  (They do things that save them 
a little bit
of money in one area and cost a lot in another area.)

This is, of course, a generalization.  I see some good things happening 
in some areas.

IMHO, this is due to the fact that these are mostly run by hardware 
engineers
and software is an afterthought.  For instance, I have dealt with one 
company who
used a non-standard interface where a standard one was available.  They 
probably
saved 1-2 dollars per board.  This change probably cost $150,000 in 
software costs.
There is no way they will sell close to 75,000 boards.  Penny-wise, 
pound-foolish.
And they have 10-20 years of support for this non-standard hack.

The more consistent you make things, the lower the software cost.  When 
you follow
standards, it lowers software costs.  Software is *expensive* to create; 
the more
you can reuse what is there, the better off you are.  It seems to me 
that the PPC
hardware vendors have spent 10s if not 100s of millions of dollars in 
software costs
that were really kind of pointless.  If things were more standard and 
consistent,
things would work just as well (and almost certainly better) and the 
cost would be
much lower.  Then us software folks who work on embedded linux could work on
making things better instead of chasing new board ports.

As I mentioned, there is a balance here.  If you are selling, 10 million 
units, saving a
dollar per unit at the cost of $150,000 in software is well worth it.  
If you can get a 50%
improvement in performance, it's probably worth it.  But to gain no 
benefit, cost
yourself a lot of money, and reduce your reliability (new software is 
generally less
reliable than old), well, that sounds silly to me.

[end soapbox]

After saying this, I don't know how to fix the PPC world.  But every 
customization
that requires software changes is one more reason for people to use x86 
(where
new boards "just work" but can be tuned for performance) and not PPC (where
new boards are pain and suffering to get working and there is no time to 
tune them
for performance).

-Corey

Date: Wed, 31 Mar 2004 10:48:27 +0200
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: debian-powerpc@lists.debian.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: hardware-monitor needs build on powerpc
Message-Id: <20040331104827.44c2612a.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040330230258.GA5163@lambda>
References: <20040329032535.GA4672@twcny.rr.com>
	<1080630229.13152.30.camel@gaston>
	<20040330110327.GA26611@lambda>
	<1080687382.1198.45.camel@gaston>
	<20040330230258.GA5163@lambda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 31 Mar 2004 01:02:58 +0200,
Sven Luther gracefully wrote:
> > On Tue, Mar 30, 2004 at 05:03:50PM +1000, Benjamin Herrenschmidt wrote:
>>
>> What I suggest is that if we ever have drivers for the thermal sensors
>> & fan controllers of the Macs, is that those driver are specifically
>> written for the Mac and not some "generic" driver for whatever
>> thermostat chip.
>>
>Yeah, well, i guess you are best placed to write those :)
>
>Friendly,
>
>Sven Luther

Just as a reminder : I've made a small module (2.6.4) to monitor
temperature on ibook G3 (with the adm103x chip) and to set fan starting
temperature (initially 76 Celcius on my ibook...).

I would be happy with some testing and some feedback.
Get it at http://cedric.pradalier.free.fr
Check /proc/device-tree/uni-n/i2c/fan/device_type to
find which chip you have.

--
Cedric

"[Of course] I'm French! Why do think I have this outrageous
accent, you silly king-a?!"  Monty Python and the Holy Grail

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alain RICHARD <alain.richard@equation.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: benh 2.4.4-pre3, Titanium and AirPort
Date: Wed, 18 Apr 2001 18:46:00 +0200
Message-Id: <20010418164600.23936@mailhost.mipsys.com>
In-Reply-To: <a05010409b70362ba0a13@[192.168.240.10]>
References: <a05010409b70362ba0a13@[192.168.240.10]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>- at module loading and without options, the driver recognize the
>card as "firmware ID 1F vendor 1 (lucent) version 7.25" and "WEP
>supported, "128"-bit key and then complains about enable to load
>module airport0 and airport1. I was thinking that airport cards where
>binded to airport0 and not eth0 by default and support only 40 bit
>mode ?

I noticed that 128 bit thing too after I did the 1.3 aiport update
from MacOS (it updated the card's firmware). No clue if the driver
is right about it or not.

The ethX by default can be changed with the eth=0 module option. It's
done that way in the original driver, I didn't change it.

>- the driver no longer seams to support the various setting as
>options for the module; what is now the recommended way of doing it ?

I removed the "enc" one that I added previously to avoid diff'ing
too much from the original source. You pass most options via
iwconfig. Just make sure to have the interface up as I keep the
card powered down when the interface is down to save power.

Ben..


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

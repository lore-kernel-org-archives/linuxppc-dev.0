From: Benjamin Herrenschmidt <bh40@calva.net>
To: Chas Williams <chas@cmf.nrl.navy.mil>,
        Chas Williams
 <chas@cmf.nrl.navy.mil>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [ANN] New kernels, gmac, airport, usb... 
Date: Tue, 4 Jul 2000 00:17:29 +0200
Message-Id: <20000703221729.18421@192.168.1.10>
In-Reply-To: <200007031226.e63CQDw25562@ginger.cmf.nrl.navy.mil>
References: <200007031226.e63CQDw25562@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>actually, if i understand the problem, the 'standard' driver wants to know
>the 56-bit key in hex and apple generates this key using the text string
>you supply (after passing it through using some hashing routine)
>
>if you have an airport basestation (with 1.1 s/w or later) you can
>see the hex string that is being used by choosing 'Network Equivalent
>Password...' under the 'Base Station' menu in the airport admin utility.

I got it to work. There was an endian problem in the driver preventing
using of the WEP mode. It's fixed in version 0.9.2. I also added a module
param for the key so you don't need iwconfig to set it

see ppclinux.apple.com/~benh for updates

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

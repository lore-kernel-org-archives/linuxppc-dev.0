Mime-Version: 1.0
Message-Id: <a05010409b70362ba0a13@[192.168.240.10]>
In-Reply-To: <20010418151519.6547@mailhost.mipsys.com>
References: <a05010406b7033c861041@[192.168.240.10]>
 <20010418151519.6547@mailhost.mipsys.com>
Date: Wed, 18 Apr 2001 18:21:44 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Alain RICHARD <alain.richard@equation.fr>
Subject: Re: benh 2.4.4-pre3, Titanium and AirPort
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >
>>01:1a.0 CardBus bridge: Texas Instruments PCI1211
>>          Flags: bus master, medium devsel, latency 16, IRQ 58
>>          Memory at 80080000 (32-bit, non-prefetchable) [size=4K]
>>          Bus: primary=01, secondary=02, subordinate=05, sec-latency=32
>>          I/O window 1: 00000000-00000003
>>          16-bit legacy interface ports at 1011
>
>I have the same chip on the Pismo that is recognized by the Yenta driver
>
>Ben.

ok, i have now tried the yenta module and it works now.

Just some more little problems :

- I am using wireless_tools.21 from Jean Tourrib (?) site and it
complains about  getting wireless extensions version 0 and needing
version 11. But iwconfig seems to work and is able to program the
card.

- at module loading and without options, the driver recognize the
card as "firmware ID 1F vendor 1 (lucent) version 7.25" and "WEP
supported, "128"-bit key and then complains about enable to load
module airport0 and airport1. I was thinking that airport cards where
binded to airport0 and not eth0 by default and support only 40 bit
mode ?

- the driver no longer seams to support the various setting as
options for the module; what is now the recommended way of doing it ?

Regards,
--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

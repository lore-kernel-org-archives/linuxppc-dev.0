Message-Id: <200007031226.e63CQDw25562@ginger.cmf.nrl.navy.mil>
To: Chris Leishman <masklin@debian.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] New kernels, gmac, airport, usb... 
In-reply-to: Your message of "Mon, 03 Jul 2000 20:02:55 +1000."
             <20000703200255.A7528@freeonline.com.au>
Date: Mon, 03 Jul 2000 08:26:12 -0400
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20000703200255.A7528@freeonline.com.au>,Chris Leishman writes:
>> base station WEP requires knowledge about the Apple key distribution
>> mecanism, and we don't have this knowledge.
>Bugger.  I was hoping to use my airport - but I don't think I'll be allowed to
>turn off security on our corporate wireless net ;)

actually, if i understand the problem, the 'standard' driver wants to know
the 56-bit key in hex and apple generates this key using the text string
you supply (after passing it through using some hashing routine)

if you have an airport basestation (with 1.1 s/w or later) you can
see the hex string that is being used by choosing 'Network Equivalent
Password...' under the 'Base Station' menu in the airport admin utility.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14782.63625.633424.277661@argo.linuxcare.com.au>
Date: Wed, 13 Sep 2000 14:46:17 +1100 (EST)
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: zeroing pages in the idle task?
In-Reply-To: <200009122018.WAA00786@piglet.grunz.lu>
References: <200009122018.WAA00786@piglet.grunz.lu>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners writes:

> clock           : 195MHz
>                   ^^^^^^
> (by the way, this is wrong. Anybody with a fix?)

I'm pretty sure that this is the number that OF is telling us, so if
it's wrong, blame OF.  You don't have a G3 upgrade card in an older
machine perhaps?

Since the only use of this number is for oohs and aahs, there's not a
lot of motivation to try and work out if OF is wrong and work out the
correct number.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>, <netdev@oss.sgi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: airport reset on iBook2
Date: Wed, 1 Aug 2001 01:10:32 +0200
Message-Id: <20010731231032.19768@smtp.wanadoo.fr>
In-Reply-To: <20010731031818.K1486@obroa-skai.gnumonks.org>
References: <20010731031818.K1486@obroa-skai.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> What is your card's firmware version ? (displayed by the driver during
>> boot). You may want to go to MacOS, upgrade to Apple's latest airport
>> software, and back to linux. This will upgrade your card's firmware to
>> the latest version provided by Apple, which might help.
>
>erm, as I said, I have a Lucent card and a x86 box.  There is no MacOS
>and I don't want to write an AirPort firmware to the Lucent card.

Oops, sorry about that. Well, what is your firmware version anyway ?

I know some have problems, and it may be wise to update using
Lucent x86 based updaters. (Or maybe it's a too-new firmware you
are running). You should really ask Jean Tourrihles or Daniel
Gibson as they know much more about these issues.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

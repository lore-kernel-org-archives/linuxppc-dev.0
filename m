From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Michel=20D=E4nzer?= <michdaen@iiic.ethz.ch>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: TiBook trackpad in benh's kernel?
Date: Wed, 18 Apr 2001 11:25:29 +0200
Message-Id: <20010418092529.13888@mailhost.mipsys.com>
In-Reply-To: <3ADCBD74.31D5B342@iiic.ethz.ch>
References: <3ADCBD74.31D5B342@iiic.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Plus, I am able to run XF4 in 32 bpp, even with cmode:8 set.
>>
>> Go figure...
>
>What did you expect? :)

Yeah, that one is really weird ;)

I noticed that lately, Apple changed Darwin trackpad code so that instead of
reading the 8 bytes of the config register, changing them, and writing them
back, it always write hard coded default values (doesn't read).

So I guess there might be a problem when reading the ADB datas from the
trackpad (timing issue) and rewriting those bogus datas cause the trackpad
to die.

I'll do some more experiments asap.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

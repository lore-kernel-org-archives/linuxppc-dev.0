From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Cc: <paulus@linuxcare.com.au>
Subject: Re: zeroing pages in the idle task?
Date: Wed, 13 Sep 2000 12:45:16 +0200
Message-Id: <20000913104516.14312@mailhost.mipsys.com>
In-Reply-To: <200009130608.IAA00768@piglet.grunz.lu>
References: <200009130608.IAA00768@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I'm pretty sure that this is the number that OF is telling us, so if
>> it's wrong, blame OF.  You don't have a G3 upgrade card in an older
>> machine perhaps?
>
>Yes, right. And I've seen OF report this before, and indeed, this info
>comes out of OF.

I remember seeing various "fixes" done by the Apple code in Darwin to
correct the bogus values returned by OF on some machines.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

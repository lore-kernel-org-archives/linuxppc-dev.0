Date: Thu, 18 Jan 2001 23:21:32 -0600
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B68D269A.586E%toe@unlserve.unl.edu>
In-Reply-To: <20010119040949.10F902F045@apollo.valhalla.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 1/18/01 10:11 PM, Iain Sandoe wrote:

> - but if you do a quick check back over this list you will find that quite a
> few 'popular' (including major ones like xmms + its plug-ins, arts, ecasound
> etc.) one have  been mentioned. (even sox produces LE raw output by default
> - yuck!).

Hmm, odd.  I've used all mentioned here except "arts" which I have never
used on a nubus mac here.  The nubus version of awacs doesn't have h/w byte
swapping.  So, I believe those apps worked at one point or fixes exist
already.

>
> Yes, the broken ones could/should all be fixed* (some have BTW) - any
> volunteers?   (I could *very* easily make the driver support hardware-only
> formats).
>
>> I don't there are so many linux audio apps to begin with.
>
> sadly, true - but there are more apps that _use_ audio - like kde - which
> _is_ (I am told) broken for pismo (I don't have one) without LE data support
> and, of course, games.

You know, some apps are so broken that they do the byte swapping themselves
so as to feed LE data, in which case the CPU will be doing double byte
swapping on PISMO and possibly others.  No thanks.

> I guess sometimes it's nice to "keep end users happy" tho' :-)

True, but we had no audio app working (without a patch or two) some years
ago, and I believe we are making progress.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <graichen@innominate.de>
Subject: Re: XFree86 4.0 auf imac dv
Date: 16 Sep 2000 14:05:33 GMT
Message-ID: <news2mail-8pvund$d4i$1@mate.bln.innominate.de>
References: <news2mail-8psnl8$1gb$5@mate.bln.innominate.de>
Reply-To: thomas.graichen@innominate.de
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de> wrote:

> does anyone here have XFree86 4 running suscessfully on a imac dv (or
> blueberry which should be basically the same)? - i ask because i tried
> the DRI test server from michael daenzer and get problems with the
> screen: it shows only the left half and also shows this half again
> on the right side - the mousecursor is moving fine over the full
> screen btw.

> some more details about the setup: latest paulus kernel, XF86Config
> standard for a r128 card (the card is an 8mb r128 rl) - if you need
> any more information please let me know ...

> so has anyone else seen this too or has it working on a similar
> machine ... i just wanted to know this before i start looking
> deeper

ok - it works with an own built tree of XFree86 4.0.1 plus the
ppc additions mentioned at linuxppc.org

question: is all the r128 ppc dri stuff in that tree (rsync
penguinppc.org::xfree86-pmac) too or are there any extra patches
required to get it working?

a lot of thanks in advance

t

--
thomas.graichen@innominate.de
technical director                                       innominate AG
clustering & security                                networking people
tel: +49.30.308806-13  fax: -77                   http://innominate.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <graichen@innominate.de>
Subject: Re: shifts on 64bit ints
Date: 4 Aug 2000 07:16:55 GMT
Message-ID: <news2mail-8mdql7$4g0$1@mate.bln.innominate.de>
References: <Pine.LNX.3.96LJ1.1b7.1000803193713.650E-100000@ofey.earthlink.net> <Pine.LNX.3.96LJ1.1b7.1000803194918.650F-100000@ofey.earthlink.net>
Reply-To: thomas.graichen@innominate.de
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe <toe@unlserve.unl.edu> wrote:

> On Thu, 3 Aug 2000, Takashi Oe wrote:

>> On Fri, 4 Aug 2000, Franz Sirl wrote:
>>
>> > Oh no!! It's even worse! The kernel implementation of ashldi3, ashrdi3 and
>> > lshrdi3 seems broken, see this code in arch/ppc/kernel/misc.S:
>>
>> The brokenness of those implementations has been noted by Gabriel a long
>> time ago, and I believe he even sent a fix to this list once.  For some
>> unknown reasons, it has largely been ignored.  I think I can dig out his
>> patch if I try hard though.

> Ok, found it:

> http://lists.linuxppc.org/listarcs/linuxppc-dev/199904/msg00189.html

nks - i'll try (think and hope :-) that this fixes the problems with
xfs ... will mail the result here later

t

--
thomas.graichen@innominate.de
Technical Director                                       innominate AG
Clustering & Security                                networking people
tel: +49.30.308806-13  fax: -77                   http://innominate.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

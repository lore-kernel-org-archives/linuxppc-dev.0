From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <thomas.graichen@innominate.com>
Subject: Re: ppc initrd problem?
Date: 3 Mar 2001 00:18:54 GMT
Message-ID: <news2mail-97pd9e$81g$1@mate.bln.innominate.de>
References: <news2mail-97967l$g4g$2@mate.bln.innominate.de> <19350119182042.5890@smtp.wanadoo.fr> <97fk7t$rb$1@mate.bln.innominate.de>
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Graichen <thomas.graichen@innominate.com> wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>>>is there any known problem with initrd's on the ppc?
>>>
>>>i am currently trying to get a small initrd based standalone system
>>>working on the ppc like i did for the i386
>>>
>>>  http://innominate.org/~graichen/projects/miniroot/
>>>
>>>to make the playing around with the xfs filesystem a bit more
>>>comfortable but it does not really boot on the ppc (new world
>>>mac, 2.4.1 kernel, SuSE 7.0/ppc) ...

>> It's a 32Mb initrd ? Well, it's possible that it gets broken then. I'm
>> not sure yaboot support such a large ramdisk. I'll give it a look.

> i have uploaded my test miniroot files at

>   http://innominate.org/~graichen/projects/miniroot/ppc/

> maybe it's a good start to look from

btw. i now also tried it with frsh yaboot (ybin) - 1.1.1 - still
the same problem ...

t

--
thomas.graichen@innominate.com
                                                         innominate AG
                                                  the linux architects
tel: +49-30-308806-13   fax: -77             http://www.innominate.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

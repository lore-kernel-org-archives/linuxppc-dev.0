From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <graichen@innominate.de>
Subject: Re: SGI XFS filesystem on ppc works now
Date: 16 Sep 2000 09:41:07 GMT
Message-ID: <news2mail-8pvf7j$n0t$3@mate.bln.innominate.de>
References: <8pvf3d$n0t$2@mate.bln.innominate.de>
Reply-To: thomas.graichen@innominate.de
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Graichen <graichen@innominate.de> wrote:
> [info: XFS is a high performance journaling filesystem from SGI
>        which is currently being ported to linux under GPL]
...
> * keep the following points in mind:

>   - do not use this for your most important data - it seems to work
>     fine but it did not have haevy testing on the ppc yet
>   - if you want to test it as root fs - add a "read-write" to your
>     yaboot.conf for the xfs root entry
>   - be patient - remounting the filesystem read-only on bootup (SuSE)
>     or shutdown (linuxppc) takes a few seconds

one thing i forgot: the tree is based on the normal linux-2.4.0-test5
kernel - so you may get problems with it on exotic hardware - because
this one does not have some things from the paulus, benh or fmlabs
trees in it (but for instance it works fine on my blueberry imac)

t

--
thomas.graichen@innominate.de
technical director                                       innominate AG
clustering & security                                networking people
tel: +49.30.308806-13  fax: -77                   http://innominate.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <graichen@innominate.de>
Subject: SGI XFS filesystem on ppc works now
Date: 16 Sep 2000 09:38:53 GMT
Message-ID: <news2mail-8pvf3d$n0t$2@mate.bln.innominate.de>
Reply-To: thomas.graichen@innominate.de
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[info: XFS is a high performance journaling filesystem from SGI
       which is currently being ported to linux under GPL]

i just want to let you know that the XFS filesystem from SGI seems
to work now quite well on the ppc now (at least on mine :-) ... it
is still not production ready (even for the i386 it is only short
before the official "beta" label :-) but in my experiences it runs
on i386 really good in daily use on all-XFS machines and i did
not have any problems on my imac in the last days too with

  graichen@aqua:~ > uname -a
  Linux aqua 2.4.0-test5 #4 Sat Sep 16 12:02:25 CEST 2000 ppc unknown
  graichen@aqua:~ > mount
  /dev/hda9 on / type xfs (rw)   <---
  proc on /proc type proc (rw)
  /dev/hda5 on /boot type hfs (ro)
  /dev/hda8 on /home type ext2 (rw)
  devpts on /dev/pts type devpts (rw)
  graichen@aqua:~ >

if anyone is interested in giving it a try:

* have a look at the SGI XFS site for more info about all that

    http://oss.sgi.com/projects/xfs/

* get my ppc patch against the SGI XFS cvs tree from

    http://innominate.org/~graichen/projects/xfs/ppc-xfs-diff.000914

* keep the following points in mind:

  - do not use this for your most important data - it seems to work
    fine but it did not have haevy testing on the ppc yet
  - if you want to test it as root fs - add a "read-write" to your
    yaboot.conf for the xfs root entry
  - be patient - remounting the filesystem read-only on bootup (SuSE)
    or shutdown (linuxppc) takes a few seconds

good luck and mail me feedback if you have some

t

--
thomas.graichen@innominate.de
technical director                                       innominate AG
clustering & security                                networking people
tel: +49.30.308806-13  fax: -77                   http://innominate.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

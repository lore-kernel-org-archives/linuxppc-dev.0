Subject: Re: XFree86-3.3.5-1.6.0b
From: MATSUURA Takanori <t-matsuu@protein.osaka-u.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990927172712I.t-matsuu@protein.osaka-u.ac.jp>
Date: Mon, 27 Sep 1999 17:27:12 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Me too. xfs cannot work with port -1. In my G3/DT233, manual operation
by root with port 7100 (xfs default port) can work.

Date: 26 Sep 1999 16:21:04 -0400
From: minyard@acm.org
Subject: Re: XFree86-3.3.5-1.6.0b

> Also, my font server stopped working.  It would lock the machine up at
> startup.
> Actually, the machine wasn't locked up, but it wouldn't
> finish booting since xfs didn't "daemonize" properly, it seems. I had
> to remove it from the rc directories.


MATSUURA Takanori @ Division of Protein Chemistry, 
                     Institute for Protein Research, Osaka University, Japan
E-Mail: t-matsuu@protein.osaka-u.ac.jp
Web Page: http://www.protein.osaka-u.ac.jp/chemistry/matsuura/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

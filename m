From: diekema_jon <diekema@lucky.si.com>
Message-Id: <200206201506.LAA17480@lucky.si.com>
Subject: Re: Memory leak
To: sgaede@attbi.com, linuxppc-dev@lists.linuxppc.org
Date: Thu, 20 Jun 2002 11:06:19 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm looking for a recipe on how to track where my memory is
> disappearing to. I am running kernel 2.4.19-pre10-ben0,
> patched for the nubus-pmac platform. I have 40 MB RAM and a
> 100 MB swap file on the local hard disk.

I have a similar problem, and I have to back down to Linux 2.4.4.
Linux 2.4.8 and newer had a problem, but 2.4.4 was ok.  Somewhere
between 2.4.4 and 2.4.8 the problem appeared.  If you want more
details as to what versions after 2.4.8 that had problem I can supply
that tonight.

2.4.4 ok
2.4.8 memory leak

Our application uses a socket based network connection, and this
network activity tickled the memory leak problem.  We can run top,
and see the amount of free memory keep dropping.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

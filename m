Message-ID: <3910942A.4224BC65@wanadoo.fr>
Date: Wed, 03 May 2000 23:03:38 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Scott Knight <scott@re-104-1.read.indiana.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: hfs
References: <Pine.LNX.4.10.10005031339350.32242-100000@fletch.read.indiana.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Scott Knight wrote:
>
>         Alright, so hfs isnt working. Is anyone out there working on it?

There is some mythical group out there working on HFS+. I guess they
should be able to fix HFS, too. Where they are should be detectable fom
the list archives.

> Does anyone have any ideas as to why it stopped working in the first
> place?

It has been broken since the introduction of the "new" page cache code
about a year ago in early 2.3.x. The official maintainer (A Sun of
netatalk fame) seems to be still alive, but nothing in terms of fixing
the code came from him for a year. Sometimes some changes show up in the
kernel trees, so that the code at least compiles, but it is still
broken.

>        I know its not a showstopper but it would sure be nice. Ill

I think it is pretty much a showstopper for LinuxPPC. The recommended
installations all use HFS partitions ("exchange" and now even "/boot")
mounted under Linux. None of them work under 2.3.x.

> probally try to look over stuff, but I dont know If ill be able to fix it,

This would really be great.

> any and all help and info, or directions to discussions about the topic
> would be greatly apprecaited. Thanks.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

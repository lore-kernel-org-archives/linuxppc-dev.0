Message-Id: <5.1.0.14.2.20020727122936.02ababf0@pop.prodigy.net>
Date: Sat, 27 Jul 2002 12:48:32 -0700
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Bitkeeper changeset numbering glitch in 2_4_devel tree
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all!

I noticed strange changeset renumbering anomaly in devel_2_4 bitkeeper tree.
It happend on July 23d, after dan@dp500.netx4.com pushed his changes
(changeset 1.1091).

Bitkeeper for some reason considers now his branch is a main line of the
development and has renumbered everything happened between Jun 7th  and Jul
23rd to be the side branch.

It looks to me that there is no way to identify any changeset in a robust way.

What today shows up as changeset 1.1155 may in future become something like
1.1088.1.30. I'm sure that Bitkeeper uses other way of identification
internally but it's not user accessible.
It's a little disturbing.

May be I'm just missing something :(.


  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

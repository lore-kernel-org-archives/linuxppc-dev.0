Message-ID: <3922583A.A23F9A57@wanadoo.fr>
Date: Wed, 17 May 2000 10:28:42 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Miles Lane <miles@speakeasy.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Today's rsync of linux-pmac-devel -- Running "more /proc/ppc_htab"
 causes a kernel check.
References: <3921BF7F.55C52D3C@speakeasy.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Miles Lane wrote:
>
> Hi,
>
> I would include more detailed info (like a symbolic stack trace),
> but I have found no information on how to collect symbolic
> traces and noone has responded to my request on linuxppc-user
> about it.

I remember several reports about this in the past weeks. Just for the
record: I never had this problem, neither with the pmac-devel nor with
the bitkeeper kernels. So this must be machine or option specific.

root[98]#more /proc/ppc_htab
No Hash Table used
Non-error misses: 002ce1b8
Error misses    : 00000000
root[99]#cat /proc/version
Linux version 2.3.99-pre9 (root@chezmoi) (gcc version 2.95.3 19991030
(prerelease/franzo)) #52 Mon May 15 11:55:59 CEST 2000

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

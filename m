Message-ID: <39F61990.6F29D8E@wanadoo.fr>
Date: Wed, 25 Oct 2000 01:21:52 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
References: <14837.11341.207379.903189@argo.linuxcare.com.au>
		<39F552C8.91856B0C@wanadoo.fr> <14837.28240.588096.139146@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Martin Costabel writes:
>
> > First of all, you don't use CONFIG_MAGIC_SYSRQ, do you? If you do, you
>
> Not usually, no.  How did you guess?  :-)
>
> > Having fixed the corresponding 6 or 8 files, compilation went through to
> > the end, but in the final "ld ... -o vmlinux", there were dozens of
> > undefined symbols, like:

Sorry for the noise, my fault. I had some files in arch/ppc/kernel left
over from earlier rsync from the (now dead) hq.fsmlabs.com server that
were newer than your corresponding ones. After a careful cleanup (and
the sysrq stuff patch), it compiles now, and boots, and works. Including
new input layer like on 2.4.0 (tested only with ADB keyboard and ADB
keycodes). And MOL (patched for 603). And MAGIC_SYSRQ :-)

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

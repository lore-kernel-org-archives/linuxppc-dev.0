MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16126.14607.782567.102349@cargo.ozlabs.ibm.com>
Date: Sun, 29 Jun 2003 10:55:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.21 patch?
In-Reply-To: <3EFE348F.26F532E7@linux-m68k.org>
References: <3EFE19DA.F151604D@linux-m68k.org>
	<20030628230400.GA930@plato.local.lan>
	<3EFE348F.26F532E7@linux-m68k.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel writes:

> I want to synchronize the APUS tree and I usually use linuxppc_2_4 for
> that. I can't use bk and the rsync tree is already at pre2.
> BTW how different is linuxppc_2_5 from Linus' tree?

The linuxppc_2_5 tree is completely obsolete.  You want the
linuxppc-2.5 tree, which is fairly close to Linus' tree.  There are
some 4xx bits in there that I will send to Linus once I am happy with
the way we do things on the 440, plus some bits for some embedded 6xx
platforms that Tom checked in there recently.

The linuxppc_2_4 tree is also pretty much obsolete.  There is now a
linuxppc-2.4 tree descended from Marcelo's linux-2.4 tree, which
should be used for any ongoing 2.4 development (which should
definitely be tapering off now).

Why do you want to work on 2.4.21 when any patch you submit will need
to be against Marcelo's latest version?  There are substantial PPC
changes in Marcelo's 2.4.22-pre2.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

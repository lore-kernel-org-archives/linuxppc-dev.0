Message-ID: <3DE2A78F.63B1B117@midrivers.com>
Date: Mon, 25 Nov 2002 15:43:27 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: "Extra cflags for kbuild 2.4." [ _devel tree ]
References: <F9102D41F595D311ACA7009027DE2C84033FFE27@c3po.heurikon.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've been away from the list for a few months and would appreciate
some larger context w/ that comment and cflags in Makefile --

I'm confused as include/linux/kernel.h includes stdarg.h, but
the 'extra cflags' specify: -nostdinc -iwithprefix include,
causing this inclusion not to be satisfied ...

commenting out:
kbuild_2_4_nostdinc	:= -nostdinc -iwithprefix include
export kbuild_2_4_nostdinc

causes the build to compile better.

my apologies if I've missed something here;

Mark


--
Mark Pilon
Minolta-QMS

P.O. Box 37
325 Dawson County Road 227
Fallon, MT.  59326-0037
1-406-486-5539 (primary voice line)
1-406-853-0433 (cell)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

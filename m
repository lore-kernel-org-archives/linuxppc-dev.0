Message-ID: <3BE08DCE.1B2E78BF@midrivers.com>
Date: Wed, 31 Oct 2001 16:48:31 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: building gdb ... no input
References: <20011031213937.C0BC611269@denx.denx.de> <3BE086F8.3A6158DA@midrivers.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


one more data point ... I copied the .tar.gz archive of gdb5.0
to a vanilla redhat 6.2 machine, did the same configure, built
a gdb and it does respond to keyboard input ...?

I've diff'd gdb/config.h between the 2 builds and there's no
difference.  any idea what else I can check for differences?

Mark

--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

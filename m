From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15723.30668.938878.54953@argo.ozlabs.ibm.com>
Date: Tue, 27 Aug 2002 22:59:56 +1000 (EST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Linux/PPC on APUS development <linux-apus-devel@lists.sourceforge.net>
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc-2.5
In-Reply-To: <Pine.GSO.4.21.0208271406320.17719-100000@vervain.sonytel.be>
References: <20020827120046.DCE42FC70@hostme.bitkeeper.com>
	<Pine.GSO.4.21.0208271406320.17719-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven writes:

> >   arch/ppc/amiga/config.c
> >     1.12 02/08/27 21:55:36 paulus@samba.org +0 -4
> >     remove kd_mksound references
>
> APUS should use arch/ppc/amiga/amisound.c:amiga_mksound().

No, APUS should define an input device that generates sounds based on
input events received.  See drivers/input/misc/pcspkr.c for how it's
done on PCs.

Regards,
Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

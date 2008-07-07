Return-Path: <roland@redhat.com>
Received: from QMTA04.westchester.pa.mail.comcast.net
	(qmta04.westchester.pa.mail.comcast.net [76.96.62.40])
	by ozlabs.org (Postfix) with ESMTP id 6B877DDEDE
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 16:41:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
In-Reply-To: Benjamin Herrenschmidt's message of  Monday,
	7 July 2008 16:23:20 +1000 <1215411800.8970.91.camel@pasglop>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
	<1215411800.8970.91.camel@pasglop>
Message-Id: <20080707063522.5FE55154246@magilla.localdomain>
Date: Sun,  6 Jul 2008 23:35:22 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm not sure... if ld.conf.d isn't parse of the kernel source tree then
> it -will- end in tears...

Of course, you should include the file you want people to install
as part of the kernel source or build.  You can copy it into
place in make install or something if you like (convention is to
call it something.conf in /etc/ld.so.conf.d); then run ldconfig.
The x86-xen case has not bothered to include its one-line file as
such, just the comment in arch/x86/vdso/vdso32/note.S telling you
what it is.


Thanks,
Roland

Return-Path: <zajec5@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3902B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 16:07:21 +1000 (EST)
Received: by qwf7 with SMTP id 7so259620qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jun 2011 23:07:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
Date: Thu, 2 Jun 2011 08:07:17 +0200
Message-ID: <BANLkTi=JRDrzn=-d8jVqZLPGtV1osa1eiw@mail.gmail.com>
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 31 May 2011 at 16:50, Christian Kujau wrote:
> trying to boot 3.0-rc1 on powerpc32 only progresses until:
>
> =C2=A0 > Kernel virtual memory layout:
> =C2=A0 > =C2=A0 * 0xfffcf000..0xfffff000 =C2=A0: fixmap

The weird thing is that:

1) You didn't see (like Andres):
Machine check in kernel mode.
 Caused by (from SRR1=3D149030): Transfer error ack signal
 Oops: Machine check, sig: 7 [#1]
But, OK, maybe machine check requires something additional in kernel,
I don't know...

2) You didn't see SSB messages
This is confusing. You should see SSB messages that appear before my
invalid read happens. Did you somehow disable most of the important
logs, or sth? Having ssb messages and the end of hung boot would
directly point you to ssb module.

--=20
Rafa=C5=82

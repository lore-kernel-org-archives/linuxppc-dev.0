Return-Path: <eddy.petrisor@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id 1A80968713
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 20:45:29 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so556294nzd
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 01:45:26 -0800 (PST)
Message-ID: <60381eeb0511120145p73189ca2o61c22ad650fd4ae@mail.gmail.com>
Date: Sat, 12 Nov 2005 11:45:26 +0200
From: =?ISO-8859-2?Q?Eddy_Petri=BAor?= <eddy.petrisor@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <4375ADA5.2080305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1130999620.4680.28.camel@gaston>
	<51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>
	<1131229041.5229.29.camel@gaston> <43751182.1020009@gmail.com>
	<1131745946.24637.251.camel@gaston> <4375ADA5.2080305@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/12/05, Eddy Petrisor <eddy.petrisor@gmail.com> wrote:
> Benjamin Herrenschmidt wrote:
> > The latest patch that is candidate for upstream is:
> >
> > Index: 2.6.14-ben/drivers/usb/core/hcd-pci.c
>
> This version also panics :(
>

Just as a note, the third and the second paniced, too.

--
Regards,
EddyP
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
"Imagination is more important than knowledge" A.Einstein

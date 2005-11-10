Return-Path: <eddy.petrisor@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.192])
	by ozlabs.org (Postfix) with ESMTP id F07C0686DD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2005 12:13:00 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so36723nzd
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Nov 2005 17:12:59 -0800 (PST)
Message-ID: <60381eeb0511091712u115979f2jf92717a3641f7952@mail.gmail.com>
Date: Thu, 10 Nov 2005 03:12:59 +0200
From: =?ISO-8859-2?Q?Eddy_Petri=BAor?= <eddy.petrisor@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1131397208.4652.41.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1130999620.4680.28.camel@gaston> <436F1A9E.80105@idtect.com>
	<1131397208.4652.41.camel@gaston>
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

On 11/7/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > i've applied your patch and it seems that when i put my powerbook to
> > sleep ( by closing the lid ) the kernel just crashes since everytime i
> > come back, the machine is turned off. I had a look at the logs and i se=
e
> > that i'm having a reboot almost immediateley after the lid is closed.
> > However i've got no trace of a kernel panic .....
> > my conf:
>
> What about this patch ?

I tried to apply this patch and the previous one over 2.6.14, but they fail=
ed.
I also tied to apply the second patch over the first, also the third
over the first, but I had the same result.

Over which version should these pacthes be applied?

--
Regards,
EddyP
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
"Imagination is more important than knowledge" A.Einstein

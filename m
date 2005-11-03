Return-Path: <eddy.petrisor@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id C4D8B68621
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2005 21:05:12 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so71781nzd
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Nov 2005 02:05:10 -0800 (PST)
Message-ID: <60381eeb0511030103w551fad25h3d9d7fa258764d5e@mail.gmail.com>
Date: Thu, 3 Nov 2005 11:03:19 +0200
From: =?ISO-8859-2?Q?Eddy_Petri=BAor?= <eddy.petrisor@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1130999620.4680.28.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1130999620.4680.28.camel@gaston>
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

On 11/3/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> For those who experience crashes on sleep and/or wakeup (typically due
> to USB) with 2.6.14, I made a test patch that might help. Please let me
> know if it makes things more reliable.
>
> http://gate.crashing.org/~benh/fix-ohci-sleep.diff

So this supposed to work with the USB sleep support enabled, right?
If this works then I will be very thankful!
I hope I have the time to test this patch this evening.

> Note that the patch is totally untested here so it may be just plain
> bogus :)

No problem.

AIUI, this should allow me to put my PB 5,2 to sleep while a usb stick
is mounted and come back from sleep with no problem and the stick to
be still mounted, right?

--
Regards,
EddyP
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
"Imagination is more important than knowledge" A.Einstein

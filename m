Return-Path: <dmitry.torokhov@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.194])
	by ozlabs.org (Postfix) with ESMTP id EE42F67A81
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 01:43:46 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id a41so817260rng
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 06:43:45 -0800 (PST)
Message-ID: <d120d50005012806435a17fe98@mail.gmail.com>
Date: Fri, 28 Jan 2005 09:43:45 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050128135827.GA28784@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
Cc: linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Jan 2005 14:58:27 +0100, Olaf Hering <olh@suse.de> wrote:
> On Fri, Jan 28, Olaf Hering wrote:
> 
> >
> > My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():
> 
> It fails also on PReP, not only on CHRP. 2.6.10 looks like this:
> 
> Calling initcall 0xc03bc430: atkbd_init+0x0/0x2c()
> atkbd.c: keyboard reset failed on isa0060/serio1
> atkbd.c: keyboard reset failed on isa0060/serio0
>

So it could not reset it even before, but it was not getting stuch
tough... What about passing atkbd.reset=0?
-- 
Dmitry

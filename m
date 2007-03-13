Return-Path: <hidave.darkstar@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id BA935DDDE9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 12:54:55 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so1679621ana
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 18:54:54 -0700 (PDT)
Message-ID: <a8e1da0703121854h161ddf2fib0235cd392b5977b@mail.gmail.com>
Date: Tue, 13 Mar 2007 01:54:53 +0000
From: "young dave" <hidave.darkstar@gmail.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Fwd: PROBLEM: 2.6.20-1 not working on ibook g4 (BUG/Oops)
In-Reply-To: <a8e1da0703121849y202b7e3clb39afca72731762d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200703051414.15802.frafore@tiscali.it>
	<1173143894.3461.240.camel@pmac.infradead.org>
	<87tzwzqgrx.fsf@briny.internal.ondioline.org>
	<1173177329.3461.291.camel@pmac.infradead.org>
	<873b4h64dm.fsf@briny.internal.ondioline.org>
	<1173265479.9349.51.camel@localhost.localdomain>
	<a8e1da0703121849y202b7e3clb39afca72731762d@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---------- Forwarded message ----------
Hi,
I have tested on my mac mini g4.

The 2.6.21-rc2 will cause oops like the above post.

And for the new 2.6.21-rc3-git7 , the kernel load ok,  penguin pixmap
appears, but then it stopped, there's no error messages also.

Regards
dave


2007/3/7, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> On Wed, 2007-03-07 at 17:53 +1300, Paul Collins wrote:
> > David Woodhouse <dwmw2@infradead.org> writes:
> >
> > > On Tue, 2007-03-06 at 14:53 +1300, Paul Collins wrote:
> > >> In case it's of interest, 2.6.20 has been running fine on my
> > >> PowerBook5,4.
> > >
> > > How much memory? What if you boot with mem=512M or mem=256M?
> >
> > 1GB.  Also works fine when booted with those options.
>
> Can you try 2.6.21-rc3 ? We just fixed a nasty bug causing memory
> corruption.
>
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

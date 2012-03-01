Return-Path: <vhtnguyen@apm.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
 by ozlabs.org (Postfix) with SMTP id 63070B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 13:59:26 +1100 (EST)
Received: by mail-lpp01m010-f42.google.com with SMTP id l5so394573lah.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 18:59:24 -0800 (PST)
From: Vinh Huu Tuong Nguyen <vhtnguyen@apm.com>
References: <1324385014-30725-1-git-send-email-vhtnguyen@apm.com>
 <CA+5PVA5SZmeEdBF0XvNmvCwroCKs1EwdWNbd_nwyEDCoZGHo2Q@mail.gmail.com>
In-Reply-To: <CA+5PVA5SZmeEdBF0XvNmvCwroCKs1EwdWNbd_nwyEDCoZGHo2Q@mail.gmail.com>
MIME-Version: 1.0
Date: Thu, 1 Mar 2012 09:53:27 +0700
Message-ID: <e2fe6a6317e1ea6e04c34281b74b2277@mail.gmail.com>
Subject: RE: [PATCH 1/3] powerpc/44x: The bug fixed support for APM821xx SoC
 and Bluestone board
To: Josh Boyer <jwboyer@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@gmail.com]
> Sent: Wednesday, February 29, 2012 8:54 PM
> To: Vinh Nguyen Huu Tuong
> Cc: Benjamin Herrenschmidt; Paul Mackerras; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] powerpc/44x: The bug fixed support for
> APM821xx SoC and Bluestone board
>
> On Tue, Dec 20, 2011 at 7:43 AM, Vinh Nguyen Huu Tuong
> <vhtnguyen@apm.com> wrote:
> > This patch consists of:
> > - Fix the pvr mask for checking pvr in cputable.c
> > - Fix the cpu name as consistent with cpu name is describled in dts
> file
> >
> > Signed-off-by: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>
> > ---
>
> I was waiting to see if you would submit a new series with patch 3/3
> fixed for
> the comments I made.  Seems you haven't yet or I missed it entirely.
> For now,
> I'll take this patch as it's stand-alone.  The DTS and PCI driver
> patches will
> need to be submitted together again.

I'm sorry for my lateness, I've been ready to submit new update 2 weeks
ago, but when I synced up with master branch again, the version of Linux
is changed (changed to 3.2) with some updates from Marri that made my
update didn't work. I have to update and test again. I'll submit the new
update within this week as your recommendation.

Best regards,
Vinh Nguyen.

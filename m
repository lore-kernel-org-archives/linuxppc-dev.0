Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 3B901DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:25:07 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so391435anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Apr 2008 19:25:05 -0700 (PDT)
Message-ID: <fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>
Date: Mon, 7 Apr 2008 20:25:05 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: Question on mpc52xx_common.c
In-Reply-To: <200804080414.42867.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com> <200804080414.42867.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 7, 2008 at 8:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 April 2008, Matt Sealey wrote:
>
> > Grant Likely wrote:
>  > >
>  > > Sure, why not?  If the firmware has already set it up correctly and no
>  > > devices using it are in use, then the kernel should be okay.  :-)
>  > > That said, I can't imagine choosing to not put the cdm node into the
>  > > device tree.
>  >
>  > *ahem* Efika.
>
>  Maybe we should just give up on making the efika boot with its regular
>  device tree and instead add a boot wrapper that either fixes up the
>  data provided by its firmware or just adds a proper dt blob?

Current kernels boot the Efika without any firmware scripts.
prom_init.c is able to handle the few fixups that the kernel really
wants to see.  (So life is mostly happy in Efika land now.  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

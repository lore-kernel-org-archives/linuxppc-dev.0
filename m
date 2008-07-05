Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 435F4DDF38
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 02:13:22 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so822637anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 05 Jul 2008 09:13:20 -0700 (PDT)
Message-ID: <fa686aa40807050913y66c92c63j22c0f46a0228285a@mail.gmail.com>
Date: Sat, 5 Jul 2008 10:13:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Andr=E9_Schwarz?=" <Andre.Schwarz@matrix-vision.de>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
In-Reply-To: <486F3F98.3060205@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <486E515B.80508@matrix-vision.de>
	<20080704170041.GD17062@secretlab.ca>
	<486F3F98.3060205@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 5, 2008 at 3:32 AM, Andr=E9 Schwarz
<Andre.Schwarz@matrix-vision.de> wrote:
> It's a MPC5200B. I thought that the "b"-Option has already out of use aft=
er
> reading about this a few weeks ago ... maybe I misinterpreted.

No, I'm *toying* with the idea, but I haven't decided yet.

> > I think it would be better to just leave out the partition information
> > and modify U-Boot to fill them in (just like memory and clock speed are
> > left out).  Things like flash partitions are less like hardware
> > description and more like configuration data.
>
> never did this. Is it quick'n'easy ?
> Honestly I don't like the bootloader to set up everything.
> If you need any change it will require a bootloader update which is a ver=
y
> fragile operation out in the field.
> There will always be bricked systems afterwards ....
> Failure in updating the (redundant) dtb blob or kernel will do almost alw=
ays
> no harm since the system is still accessible and flashable using ethernet=
 or
> serial.
>
> If it's not against all rule (which I don't think) I'd really like to sti=
ck
> to it, too.
> Is this ok ?

hurumm... okay, leave it in.  I suppose it isn't a risky thing to do.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

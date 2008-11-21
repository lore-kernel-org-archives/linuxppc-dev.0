Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 5EB6FDDDE3
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 01:59:17 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so401662yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:59:16 -0800 (PST)
Message-ID: <fa686aa40811210659l3b9a4eefwf6eb59f66386d379@mail.gmail.com>
Date: Fri, 21 Nov 2008 07:59:14 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: gianfranco.casanova@alice.it
Subject: Re: R: R: USB on lite5200 does not work.
In-Reply-To: <47602D18F269934AB73B7E550804A1E002137973@FBCMST09V03.fbc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
	<fa686aa40811200656g783947f5l609650b707c6c883@mail.gmail.com>
	<47602D18F269934AB73B7E550804A1E00213796F@FBCMST09V03.fbc.local>
	<fa686aa40811200749xd9f8701ud6ee9b77b4c21001@mail.gmail.com>
	<47602D18F269934AB73B7E550804A1E002137973@FBCMST09V03.fbc.local>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 21, 2008 at 1:36 AM,  <gianfranco.casanova@alice.it> wrote:
> Hi Grant&Wolfgang
>
> thanks for yours posts. You are right about WR. For lite5200 only few patchs
> have been used. Most of the job is for support other boards or to introduce
> some patchs for its debug system.
>
> The main HW difference between our board and lite5200 is:
> console on PSC3 and
[...]
> on our HW defined as:
>         /* Radionav configuration */
>         port_config =  0x0C712E66;
>

You've got quite a bit of difference than just console on PSC3.  USB
is on the Ethernet pin group instead of on the USB pin group.  Does
the kernel change the value of port_config when it boots, or does it
leave the value setup by U-Boot intact?

> I still do not understand our bug with USB.
> Have you got some suggestions or some test to be performed in order to find
> out a solutions?

Not over a quick exchange via email.  Your kernel is too old and USB
debugging can be complex.  I'd need to be working with your hardware
to figure out what is going on.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Message-ID: <3C896322.E0394EAE@esteem.com>
Date: Fri, 08 Mar 2002 17:19:30 -0800
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linux-2.4.18 & copy-back cache mode
References: <D3A72C5007329A4F991C0DD87202259F096A96@sekhmet.ad.newisys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin Boppuri wrote:
>
> I am sorry. I meant 64Mhz , not 66Mhz.
>
> Navin.
>
> -----Original Message-----
> From: Navin Boppuri
> Sent: Thursday, March 07, 2002 2:33 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Cc: laurent.pinchart@capflow.com
> Subject: RE: linux-2.4.18 & copy-back cache mode
>
> I am running my MPC855T at 66Mhz 1:1 CPU/bus clock mode without any problems. I used an app. note from Motorola to do this and according to the app.note, we just need to satisfy some timing constraints on the processor (latency of data reaching the MPC pins from SDRAM). The app. note suggests using specific Micron SDRAM which satisfy all these requirements.
>
> Navin.

Which app note was this? Does any body know if it will work on an
MPC850?

Thanks,

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

Stock Ticker Symbol				ELST

"clark@esteem.com" Copyright 2000 By Electronic Systems Technology
 This email address may be used to communicate to Conn Clark
 provided it is not being used for advertisement purposes, unless
 prior written consent is given. This email address may not be
 sold under any circumstances. All other rights reserved.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

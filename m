Message-ID: <17B78BDF120BD411B70100500422FC63079FA7@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: "'Tom Roberts'" <tjroberts@lucent.com>, Dan Malek <dan@netx4.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Query: kernel version for MPC750/MPC7400
Date: Tue, 27 Jun 2000 16:22:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Classic linux kernel like 2.2.16 works well and reliably on PPC 7xx
processors.
The Monta Vista kernel is only tested on 8xx processor, and the 7xx support
is probably broken.

Patrick LERDA

> -----Message d'origine-----
> De:	Tom Roberts [SMTP:tjroberts@lucent.com]
> Date:	mardi 27 juin 2000 16:00
> À:	Dan Malek
> Cc:	'linuxppc-embedded@lists.linuxppc.org'
> Objet:	Query: kernel version for MPC750/MPC7400
>
>
> Dan Malek wrote:
> > You shouldn't be using 2.2.15 with 8xx.  I am not going to discuss
> > the history right now, but the only reliable verion of 2.2.xx Linux
> > is the 2.2.13 version on the MontaVista Web site (www.mvista.com).
>
> How about on an embedded MPC750 or MPC7400? Before joining this
> list I discovered Kernel version 2.2.15 on Yellowdog and have been
> using that. I have made a dozen or so small mods to the kernel to
> get it to run on our boards, and have seen no problems, so far....
> There are zillions of references to CONFIG_8xx throughout the source.
>
> 	These boards are essentially embedded supercomputers;
> 	the only devices they have are the drivers I wrote, which
> 	use memory buffers to/from the host PCI as a 'serial'
> 	console and a network interface.
>
>
> Tom Roberts	tjroberts@lucent.com
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

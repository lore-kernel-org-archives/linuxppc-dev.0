Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a08b57676893fce@[129.116.176.243]>
In-Reply-To: <XFMail.000621153237.pochini@shiny.it>
References: 
 <Pine.LNX.4.21.0006200827480.1155-100000@pegmatite.iu13.k12.pa.us>
Date: Wed, 21 Jun 2000 08:44:33 -0500
To: Giuliano Pochini <pochini@shiny.it>, linuxppc-dev@lists.linuxppc.org
From: Mike DeSimone <desimone@arlut.utexas.edu>
Subject: Re: Slow Adaptec
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Is there any boot parameter or so to make it work in "ultra" mode ?

I think what you want is in this clip from
/usr/src/linux/drivers/scsi/aic7xxx.c:

 *  A Boot time option was also added for not resetting the scsi bus.
 *
 *    Form:  aic7xxx=extended
 *           aic7xxx=no_reset
 *           aic7xxx=ultra
 *           aic7xxx=irq_trigger:[0,1]  # 0 edge, 1 level
 *           aic7xxx=verbose
 *

So you might try aic7xxx=ultra or aic7xxx=ultra,verbose.

I have no idea if this works or will even do anything; I just remember
running across this when trying to debug a tape drive problem.
_______________________________________________________________________________
Mike DeSimone        Applied Research Laboratories: The University of Texas
Research Engineer    Mail to: PO Box 8029       Shipments to: 10000 Burnet Rd.
Sonar Development             Austin, TX 78713                Austin, TX 78758
Office (512) 835-3061-------FAX (512) 835-3259--------desimone@arlut.utexas.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

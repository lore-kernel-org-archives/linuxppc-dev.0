Date: Fri, 29 Jan 1999 16:45:01 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>
cc: minyard@acm.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Force CompactPCI cards
In-Reply-To: <36B1932A.2AB39305@mailserv.rz.fh-muenchen.de>
Message-ID: <Pine.HPP.3.96.990129163842.2291R-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 29 Jan 1999, Christian Zankel wrote:

> 
> Hello Corey,
> 
> > 
> > Is anyone working on or interested in Linux of the for CompactPCI
> > cards with the 750 processor?  Just curious...
> > 
> 
> Actually, I have a 750 VME board here I want to start working on it as
> soon as I can find some time for it. (Probably in a week, when I have
> finished my exams).
> 
> I don't see much difficulties porting linux to the board as it mostly
> uses standard components. And the main work seems to be already done
> (Thanks to everyone working on the ppc-port! You did a great job!). 
> Perhaps it might take more effort to write an own booter, like the
> 'milo' on alpha architectures, to replace the Powerboot/vxWorks-booter.

It depends on what the board provides, some residual data, an OF like
device tree or nothing (worst case since interrupt routing may be the
biggest problem)... But if it uses a Motorola bridge (MPC106) as it seems
the port will be quite easy, you only have to know whether it
boots in PreP mode or in CHRP mode to know the basic mapping of the
system (to know how to access PCI config space...). 

> I might be completely on the wrong way, so I'd really appreciate any
> comments, if the arch/ppc should be and will be restructured or if less
> common used platforms should be left out of the mainstream kernel, etc.

Restructuring efforts have been announced and some patches are floating
around.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

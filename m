Date: Tue, 20 Apr 1999 16:46:05 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MVME zImage works
In-Reply-To: <Pine.HPP.3.96.990420155448.20020G-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9904201639110.3400-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, Gabriel Paubert wrote:

> > * ``make modules'' fails (because of universe.c -- to be solved soon, I
> >    hope). The modules missing isn't really a problem since almost
> >    everything you need should be in the kernel image.
> 
> solved but you'll need to upgrade to 2.2.6.

 I'm patching the kernel source tree right now.

> > (Gabriel, I have another question : I noticed you updated the .config's
> >  on your site. Are they for 2.2.4 or for 2.2.6 ?)
> 
> They are for 2.2.6, although there are very few differences. Actually make
> oldconfig did not ask any questions when updating the nfsroot config to
> 2.2.6. For the other, the only question is related to tyhe split of the
> Symbios/NCR driver and you should answer N (the new one does not work for
> now). 

 I'd have to say N anyway, since our board has no SCSI controller.

Kind regards,

+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Watching eyes wait for sadness to rise,
 true superstitions combine and thicken
 this poison that reaches my soul,
 this terror that blackens my soul."
 - Anne Clark
+-----------------------------------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

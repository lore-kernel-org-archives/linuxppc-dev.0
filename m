Date: Fri, 12 Mar 1999 14:10:47 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Lundkvist <ml@epact.se>
cc: David De Ridder <david.de.ridder@bitsmart.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <qphfrxhw15.fsf@erbium.epact.se>
Message-ID: <Pine.HPP.3.96.990312140258.1078B-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On 7 Mar 1999, Michael Lundkvist wrote:

> Aaaaah! This one helped a lot!
> 
> But I'm not quite there yet. Now the kernel panics when it tries to
> configure the ethernet devices.
> 
> It looks to me like it dies in net/ipv4/ipconfig.c:ic_open_devs since
> i see the line "IP-Config: Entered." but I never see the 
> "IP-Config: Opened %s (able=%d)\n", dev->name, able).
> 
> I'm attaching the boot log and I'm cc-ing to linuxppc-dev to see if
> anyone there has any help to give me.
> 

> My board is a MVME 2307SC-1 with 64MB RAM and a DEC 21143-TD etherne chip.

Matt Porter had a fix for the problems with the 21143, but I don't know
where they can be found. Perhaps it will be simpler now that vger is back
(although I won't switch back to vger for at least a few weeks). 

> Is there anymore info I can provide. I feel like I know absolutely
> nothing about this hardware.

BTW: my driver for the Universe (PCI<->VME bridge chip) is now close to
its final state. It still needs some cleanup, but I hope to be able to ask
for testers next week.  (Even DMA is working now, this was quite a
headache to get right and it took me several iterations to find a simple
and relatively easy to use interface for the callers). 

	Regards,
	Gabriel.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

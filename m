Date: Tue, 2 Mar 1999 15:38:46 +0100 (MET)
From: "David.DeRidder" <s970707@uia.ua.ac.be>
Reply-To: loopback <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel boot arguments over network
In-Reply-To: <Pine.HPP.3.96.990302103807.3871Y-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9903021537000.13750-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2 Mar 1999, Gabriel Paubert wrote:

> > in my continueing efforts to get our MVME2306 board running, I ran
> > across another problem. All Linux (mini-)HOWTOs talk about passing
> > boot arguments (like 'root=/dev/nfs') to the kernel. Some also
> > mention the case where one is booting a diskless station (such as
> > an MVME230x board). However, no document describes *how* to pass these
> > arguments over the network to the kernel.
> 
> You don't have to (and can't AFAICT). For now on my MVME2302, I have to
> sit at the serial console and add root=/dev/nfs to the LinuxPPC boot

 For the record, there is no difference as far as the kernel is concerned
 between an MPC603 (as in your MVME2302) and an MPC604 (as in our
 MVME2306) ?

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"Every dog has its day, and today's mine."
 Terry Borer after winning the Masters finals at the New York M:TG Pro Tour 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

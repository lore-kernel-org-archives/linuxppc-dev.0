Date: Tue, 2 Mar 1999 17:00:07 +0100 (MET)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel boot arguments over network
In-Reply-To: <Pine.HPP.3.96.990302162445.3871g-100000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9903021654160.16858-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2 Mar 1999, Gabriel Paubert wrote:

> On Tue, 2 Mar 1999, David.DeRidder wrote:
> 
> >  I'd expect at least a message reporting that is the case). If not,
> >  there must be another problem...
> 
> No, I would rather think that there is a problem with the universe. Plese
> rerun the ENV command and answer 0 or N to all questions about the VMEPCI3

 That's it !! There is a setting called "VME3PCI Master Master Enable".
 This is the culprit for the kernel not booting. It must be set to 'N'
 for the kernel to boot. (That, and setting the PReP mode correctly,
 as discussed previously on the list). The kernel now comes up, as
 it should !

> bridge. The default settings might interfere with the reallocation of
> PCI resources (I'm working on making the Universe known to the PCI code
> to avoid conflicts). 

 Well, I'm still having a problem for the kernel to gain access to
 the NFS server - but that seems a minor issue. (They talk to each
 other, but the NFS server is reluctant in giving access - /etc/exports
 seems to be correct).
 
 I'll keep you posted about our progress.

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

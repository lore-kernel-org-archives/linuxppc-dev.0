Date: Mon, 22 Mar 1999 13:45:25 +0100 (MET)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Michael Lundkvist <ml@epact.se>
cc: David De Ridder <david.de.ridder@bitsmart.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <qpsoaxd7ze.fsf@erbium.epact.se>
Message-ID: <Pine.SO4.4.05.9903221342440.18896-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 22 Mar 1999, Michael Lundkvist wrote:

> David De Ridder <s970707@uia.ua.ac.be> writes:
> 
> > 
> >  So, the kernel seems to be requesting those files (and receiving them ?).
> >  You could be right about the dynamic libraries. But, before I reinstall
> >  the entire root fs, I want to make sure *that* is the problem. Does
> >  any of you kind people have a statically linked program I could use to
> >  test, e.g. a Hello World program ?
> > 
> 
> Try /bin/rpm.

 Thank you ! The dynamic libraries seem to be the problem. You suggest to
 go for an R5 instead of R4 ? I noticed at several FTP sites that there
 are only so-called 'pre-R5' RPMS available. Are those the ones you mean ?

 Kind regards from rainy and traffic-congested Belgium,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"Only the bamboo bows when the storm grumbles. Steel breaks !"
 - Yemitsu, last words


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

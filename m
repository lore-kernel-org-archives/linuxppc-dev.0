Date: Tue, 20 Apr 1999 16:33:41 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Gabriel Paubert <paubert@iram.es>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Tulip (was: Re: mvme kernel patches [LONG])
In-Reply-To: <Pine.LNX.4.10.9904201627060.26859-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.SO4.4.05.9904201631560.3400-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, Geert Uytterhoeven wrote:

> > > * Why is the Generic DECchip driver used instead of the DEC2x41x driver ?
> > >   Is this because of the problems with the DEC21143 ?
> > 
> > Arenn't you confused ? I think they are the sme driver under evolving
> > names. The source file is de4x5.c, tulip.c has never worked properly on
> > big endian machines. There are still problems with my source on 21143, but 
> > Matt Porter just posted agin the necessary patches. 
> 
> As of v0.91, tulip.c works again (verified by a friend with a LongTrail).

 OK. I will try it with a 2.2.6 on our MVME2306 board (DEC21140).

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

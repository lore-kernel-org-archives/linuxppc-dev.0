Date: Tue, 20 Apr 1999 16:29:06 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Gabriel Paubert <paubert@iram.es>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mvme kernel patches [LONG]
In-Reply-To: <Pine.HPP.3.96.990420160610.20020H-101000@gra-ux1.iram.es>
Message-ID: <Pine.SO4.4.05.9904201625060.3400-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, Gabriel Paubert wrote:

> >  Yes, and doing an entire kernel configuration is not funny on a serial
> >  terminal (at least, not with make menuconfig). Maybe an ncurses bug...
> 
> I understand. But can't you run X on a remote display ? make menuconfig
> runs fine through telnet too. 

 If only I could telnet to the board...
 I cannot create extra users (in a useful way), and I cannot login as
 root with a telnet session. I suspect PAM for being responsible.
 I've already spent several hours tracing this, but I am a complete
 PAM newbie. Probably one stupid entry in one lousy file...

> >  You will notice that our mails just missed each other ;-)
> 
> Yes, and also that the mailing list is sloooowwww...

 Indeed !

> >  Rats !  Hmm, do you think it is safe to unpatch to a standard 2.2.4,
> >  then apply 2.2.5 and 2.2.6 upgrade patches, and then your new patches ?
> >  (Installing an entire kernel tree takes long, since I only have NFS
> >  access to the destination server). Or, maybe you could send me your
> >  universe.h...please...pretty please...
> 
> It should be safe. But I have attached it anyway.

 Ok, I'm going to try the whole patch circus now, and hope to get in the
 end a working 2.2.6 with VME support.
 
 I'll keep you posted,

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

Mime-Version: 1.0
Message-Id: <v04220601b41856b2aa72@[192.168.1.5]>
In-Reply-To: 
 <Pine.LNX.3.96L.990929163345.7639E-100000@unix47.andrew.cmu.edu>
References: 
 <Pine.LNX.3.96L.990929163345.7639E-100000@unix47.andrew.cmu.edu>
Date: Wed, 29 Sep 1999 18:57:34 -0500
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
From: Justin Shore <macdaddy@vinnie.ksu.ksu.edu>
Subject: Re: BootX app w/o dialog
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:43 PM -0400 9/29/99, Hollis R Blanchard wrote:
>I'm talking with someone in charge of an iMac cluster who needs to use Linux
>by night and the Mac OS by day and have everything automated. When the
>machines reboot (from a cron job) in the morning they need to come up into the
>Mac OS. Since the drives are HFS+ formatted switching BootX preference files
>in the cron job won't work.
>
>The deal is I'm going to be looking into a BootX application (not extension)
>with the dialog hacked out of it so it automatically starts Linux with the
>default settings when launched. I looked a little at the BootX code and I
>don't think it would be that hard. I think I have an old CodeWarrior (10) I'm
>willing to install and play with, but I'm pretty busy so I wanted to see if
>anyone (other than BenH, who's busy kernel hacking :) could take a look and
>hopefully produce a binary.
>
>Let me know if you're game.
>
>-Hollis
>


	Well, how I would do it would be like this.  Configure the 
BootX app to automatically start into LPPC (um, I'm not sure if the 
app is scriptable--this would be required).  Using a program like 
MacAt have it launch BootX at a certain time.  Then create a cron 
within LPPC to reboot.  Since you don't have the extension in the 
extensions folder (hint hint), it will boot back into MacOS and start 
the process over again.  This all depends on whether or not BootX is 
scriptable enough to hit return (or if you could hack it and insert 
the timeout code from the extension into the app).  Anyhow, that's my 
2¢.  Good luck!

Justin

Cron
http://gargravarr.cc.utexas.edu/cron/cron.html

MacAt
http://gimr.garvan.unsw.edu.au/gerham/macsos/macat/index.html


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

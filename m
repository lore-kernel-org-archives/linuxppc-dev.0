Message-Id: <v04003a03b508bf7a8682@[24.66.67.189]>
In-Reply-To: 
 <Pine.LNX.4.10.10003300955350.19014-100000@opal.biophys.uni-duesseldorf.de
 >
References: <38E27BDD.4DEDC1E4@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 30 Mar 2000 02:32:59 -0600
To: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
From: Tony Mantler <eek@escape.ca>
Subject: Re: adb_buttons kernel argument
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:02 AM -0600 3/30/2000, Michael Schmitz wrote:
>> > Well, change the documentation. I think somebody is integrating my
>>xpmac-style
>> > adb_buttons support and so there will be a adb_buttons=2,xx,yy soon. I
>>think
>> > the old syntax was a little bit strange anyway and probably was only a
>>mistake
>> > and no intended behaviour.
>>
>> Yes, please! I have been using the adb_buttons=2,xx,yy patch for more
>> than a year now on both 2.2.x and 2.3.x. It would be nice to have it
>> integrated in the kernel, so I don't have to patch it every time. If
>> someone wants a version for 2.3.99, I can mail it.
>
>Could you please describe what adb_buttons=2,xx,yy does different than
>adb_buttons=xx,yy (2.2 style) would do?
>Please keep in mind that the adb mouse code is shared with the m68k Mac
>port. I'm sure people there would like to get a heads-up about changes to
>the syntax too.

Providing we m68k Mac folk can actually keep our 2.3/4 tree up to date and
bootable. *sigh*

Speaking of which, if any of you folk have some old 68k Mac hardware laying
around and need a break from PPC hacking, feel free to contribute! The info
and stuff is at <http://www.mac.linux-m68k.org/>, or drop by #Linux-Mac68k
on the openprojects irc network.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

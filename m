Message-ID: <19990721074712.12470.qmail@ww181.netaddress.usa.net>
Date: 21 Jul 99 00:47:12 PDT
From: skinny boeceifus <mudskinny@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: re: Support for Mouse Systems A3 protocol mice
CC: aidan@kublai.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
 
Your patch is working great for me, but I did have one complication with it,
or mabey my own stupidity. I was thinking- yea I'll unplug my mac point pro
and try my old one button to see if it would work. So I did it(without
rebooting, thats where my stupor came in).. The pointer moved but I couldnt
click any thing or type anything, So I had to hard reboot **, and got to the
login screen(with the mac point pro pluged in) to find the keyboard still
wouldn't work but the mouse did, and about that time my keyboard started
smellin' like burnt board. luckily I managed to cut and paste my login and
password to log in and reboot:) to make a long story shorter, I booted to
macos, unplugged and replugged the keyboard, then rebooted. Now it works
perfectly.. I thought this was pretty weird so thats why I write this.

Thanks!
from Bob
 
 >Date: Sun, 18 Jul 1999 14:49:49 -0400
 >From: Aidan Cully <aidan@kublai.com>
 >To: linuxppc-dev@lists.linuxppc.org
 >Subject: [PATCH]: Support for Mouse Systems A3 protocol mice

 >This patch adds 3-button support for (at least) the Mouse Systems A3
 >Trackball, and Mac Point Pro products.  I've also changed a bit of how
 >the button-change logic works, since I think it's allowed for mice to
 >slip back into the 1-button mouse protocol.  I don't know if that's
 >entirely appropriate, but both Darwin and NetBSD seem to take that
 >precaution..
 >
 >The patch is against kernel 2.2.10.  Hopefully, someone here will know
 >how to get it integrated into new kernel revisions.
 >
 >I'm not subscribed to this list, so please CC: any replies to me.
 >Thanks,
 >--aidan



____________________________________________________________________
Get your own FREE, personal Netscape WebMail account today at http://webmail.netscape.com.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

In-Reply-To: <19990721074712.12470.qmail@ww181.netaddress.usa.net>
Date: Wed, 21 Jul 1999 11:54:54 +0200
To: skinny boeceifus <mudskinny@netscape.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Support for Mouse Systems A3 protocol mice
Message-Id: <19990721115454.015534@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 21, 1999, skinny boeceifus <mudskinny@netscape.net> wrote:

>Your patch is working great for me, but I did have one complication with it,
>or mabey my own stupidity. I was thinking- yea I'll unplug my mac point pro
>and try my old one button to see if it would work. So I did it(without
>rebooting, thats where my stupor came in).. The pointer moved but I couldnt
>click any thing or type anything, So I had to hard reboot **, and got to the
>login screen(with the mac point pro pluged in) to find the keyboard still
>wouldn't work but the mouse did, and about that time my keyboard started
>smellin' like burnt board. luckily I managed to cut and paste my login and
>password to log in and reboot:) to make a long story shorter, I booted to
>macos, unplugged and replugged the keyboard, then rebooted. Now it works
>perfectly.. I thought this was pretty weird so thats why I write this.

If you hot-swap devices on the ADB bus, you need to reset and re-probe
it. I added code for that (used by Powerbook sleep code) and it can
theorically be triggered from userland by sending the ADB_RESET command
to /dev/adb. I never tested this however, you'll have to write a (simple)
command line tool for that.

I'll try to find some time this week or next week to gather all those
pending ADB patches, and upload the trackpad tool in a place that can be
reached easily. I also have some other tools that I should make available
once they are cleaned up like one for sending this reset command and
another for configuration various Microspeed mouse options. Stay tuned, I
think I'll be able to do that later this week or next week-end.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

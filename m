In-Reply-To: <37C64B37.49029CC6@wanadoo.fr>
Date: Fri, 27 Aug 1999 11:21:40 +0200
To: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: vger-2.3.15 on pmac
Message-Id: <19990827112140.011174@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 27, 1999, Martin Costabel <costabel@wanadoo.fr> wrote:

>For drivers/macintosh/mac_keyb.c, I applied also BenH's patches that are
>in the 2.2 branch on vger, but not yet in the main branch. For me, this
>has the effect that the keyboard gets put on handler 3 instead of 5, so
>that in raw mode it produces different keycodes for the right modifier
>keys, and I can therefore use adb_buttons=2,58,124 to get
>button2=Opt_L+click, button3=Opt_R+click, like in Xpmac.

I'm not sure my patches are still needed. The last time I synced with
Paul's tree, the handler ID bug was fixed, but I didn't check vger yet.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

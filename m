In-Reply-To: <19990330125854.000150@mail.mipsys.com>
Date: Tue, 30 Mar 1999 21:22:54 +0200
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Yesterday vger and ioremap
Message-Id: <19990330212254.017483@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 30, 1999, Benjamin Herrenschmidt <bh40@calva.net> wrote:

>Apparently, the kernel works fine, PA seems to always be equal to VA, and
>apparently, this concerns all addresses on the Apple asic (mac-io on the
>G3), at f30xxxxx. 
>Since this is mapped with a BAT, I'm wondering if this could be a
>conflict between new ioremap changes and BAT mapping ?

I was wrong, actually, the kernel  doesn't work, looks like IP or
ethernet is just dead. I don't have enough time to look at this now
(using bmac ethernet on a desktop G3, I didn't test another machine yet).


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

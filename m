In-Reply-To: <19990310123639.A292@giordino.point-barre.fr>
Date: Wed, 10 Mar 1999 13:19:08 +0100
To: Hubert Figuiere <hub@point-barre.fr>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: ADB Reset
Message-Id: <19990310131908.030129@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 10, 1999, Hubert Figuiere <hub@point-barre.fr> wrote:

>I could reset the adb bus with adb_reset_bus(), but it did
>nothing in my case. Mouse was still SLOW, etc.
>I called adb_scan_bus() instead. But this happen to not work and
>make my mouse no longer be recognized.
>
>Any idea on what to do ?

After the bus reset, the mouse must be re-initialised to handler 4. In
fact, the whole device probing and init must be redone (mac_keyb.c). I'm
working on a simple design that allow ADB peripherial drivers to register
to the ADB core in order to be notified of bus resets. Stay tuned.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

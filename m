Date: Thu, 11 Mar 1999 08:55:37 +0100
From: Hubert Figuiere <hub@point-barre.fr>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB Reset
Message-ID: <19990311085536.A1755@giordino.point-barre.fr>
References: <19990310123639.A292@giordino.point-barre.fr> <19990310131908.030129@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990310131908.030129@mail.mipsys.com>; from Benjamin Herrenschmidt on Wed, Mar 10, 1999 at 01:19:08PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to Benjamin Herrenschmidt <bh40@calva.net>:
> 
> After the bus reset, the mouse must be re-initialised to handler 4. In
> fact, the whole device probing and init must be redone (mac_keyb.c). I'm
> working on a simple design that allow ADB peripherial drivers to register
> to the ADB core in order to be notified of bus resets. Stay tuned.

This is really ugly. Why the hell is mouse related code in the keyboard
driver ? I may understand that since it is ADB they are related, but
I find this not really clean.
I'll look at this...


Hub
-- 
World Wide Wait: the real meaning for WWW.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

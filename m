Date: Wed, 10 Mar 1999 17:40:09 +0100
From: Hubert Figuiere <hub@point-barre.fr>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB Reset
Message-ID: <19990310174009.A1526@giordino.point-barre.fr>
References: <19990310123639.A292@giordino.point-barre.fr> <19990310131908.030129@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990310131908.030129@mail.mipsys.com>; from Benjamin Herrenschmidt on Wed, Mar 10, 1999 at 01:19:08PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to Benjamin Herrenschmidt <bh40@calva.net>:

> After the bus reset, the mouse must be re-initialised to handler 4. In
> fact, the whole device probing and init must be redone (mac_keyb.c). I'm
> working on a simple design that allow ADB peripherial drivers to register
> to the ADB core in order to be notified of bus resets. Stay tuned.

That would be cool if we can get the "adb_mouse_kinds" array (or
at least the current mouse kind) within the adbmouse.c driver.
This would allow to make the driver works at the right speed with
Kensington mice....
I have made such patch that seems to be on the right way (I could
not validate it completely).

BTW, while I'm at it, it looks like extended ADB protocol provide
"high bits" for dx and dy, but they seems to be unused in
adbmouse.c. Any ideas for this ?


Hub
-- 
World Wide Wait: the real meaning for WWW.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

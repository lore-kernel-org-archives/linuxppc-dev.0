Date: Tue, 22 Dec 1998 14:49:26 -0700 (MST)
From: john s jacobs anderson <jacobs@azstarnet.com>
To: Mark Abene <phiber@radicalmedia.com>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: TurboMouse fix
In-Reply-To: <19981222132904.J16123@radicalmedia.com>
Message-ID: <Pine.LNX.3.96.981222144709.10207A-100000@lazarus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bad morning, Mark? 

> 1) mousehack is **ONLY** for TurboMouse 5.0 trackballs!  Not two button 4.0's.
> I had written a hack last year for my 4.0, but abandoned it when I got a 5.0.
> The 4.0 would actually require kernel mods to the ADB code since the two buttons
> send left and right arrow-key keycodes, and the kernel would have to recognize
> that they were coming from a different ADB address in order to properly treat
> them as mouse-button events.  Otherwise, the kernel just thinks you have two
> keyboards.  At least in kernel 2.1.24, the adb code treats anything with 
> dev-handler 2 as a keyboard, which in this case is faulty logic.

ok. 

> 2) You should NEVER edit source code with pico, since it breaks wrapped lines
> which turns source code into useless mulch.

did you look at the source? none of the lines were that long; I didn't
have emacs open, and vi(m) still gives me headaches. But thanks for the
heads up.

> 3) Did you type in your error messages by hand?  The macro used in my program
> is ADB_WRITEREG, with an underscore, not a hyphen.  It's no shock that the
> hyphenated version is undefined, as it don't exist.

yes, I did, and yes, my finger apparently slipped off the shift key for
the duration of the - keystroke. Mea maxima culpa, eh?

john.





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

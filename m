To: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
From: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
In-Reply-To: Your message of "Sun, 6 Dec 1998 16:13:38 +0100 (MET)"
	<Pine.LNX.4.02.9812061549490.323-100000@cassiopeia.home>
References: <Pine.LNX.4.02.9812061549490.323-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19981207225752U.khosoda@venus.dti.ne.jp>
Date: Mon, 07 Dec 1998 22:57:52 +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> On Sun, 6 Dec 1998 16:13:38 +0100 (MET), Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be> said:

>> Did you fix the problem with the non-working option (alt)
>> keys?  In the XF68_FBDev of the new R5beta linuxppc, it
>> is still there.  For me (PM6400, standard Apple keyboard
>> and 1-button mouse), XF68_FBDev is pretty much useless.

Geert> What about the XF68_FBDev from XFree86 3.3.3?

Hi,

I just installed Xfree86-3.3.3 and XF68_FBDev on PowerMac
8500/120 (standard Apple keyboard, 1-button mouse and
linuxpmac 2.1.125).  The situation was the same as Martin.
So, I added adb_buttons=1 in boot-file and restarted the
system.  Then it seems to me that option key itself acts
like right button.  However, there is no middle button
emulation.

Somebody in this list I can't remember (sorry) wrote that
adb_buttons=1 option enable the right option- and control-
keys to emulate mouse buttons.  Unfortunately, my standard
Apple keyboard has left option- and control- keys but does
not have right ones. :-(

Kohkichi Hosoda

E-mail address: khosoda@venus.dti.ne.jp

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

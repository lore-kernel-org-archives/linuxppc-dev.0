Message-ID: <3831F1FA.98719C5D@tiac.net>
Date: Tue, 16 Nov 1999 20:08:29 -0400
From: Patrick Callahan <pac1@tiac.net>
MIME-Version: 1.0
To: yellowdog-general@lists.yellowdoglinux.com,
        yellodog-devel@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerBook G3 internal modem
References: <38312608.D1257E8E@free.fr>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There's some problem I have that prevents kppp from working correctly when I
start it from a terminal window of a user account. When started this way it
freezes after receiving just a few packets.    When started from a terminal
window that has been su'ed to root,   It works just fine.

I don't know what the cause of this problem is, but I could reproduce it several
times on one occasion.   I havn't tried to run kppp from the user account since.

Hey developers, I saw something in the lists recently about ppp freezes.  are we
on to something with this user vs root stuff or are we just ignorant of something
and need to set stuff up correctly so it works from the user account.

-Pat  icq 17780787

Gilbert Fernandes wrote:

> Hello,
>
> I've installed CS 1.1 on a PowerBook G3, WallStreet II model.
>
> I' using KDE, and I've configured kPPP and I've got a problem. The
> internal modem (cobalt modem) is at ttyS2. If I open a console, I can
> launch minicom and communicate with the modem (I've setup /dev/modem to
> /dev/ttyS2). I can give the modem an ATZ and do whatever I want.
>
> When I'm using kPPP under KDE, I got more trouble. First, I can only use
> the dialing once. If I try to connect, everything works fine, but once I
> was connected, everything freezed! I couldn't do anything: I tried
> clicking in the KDE tool bar, launching a console (I didn't know about
> the Option+Ctrl+Fn at that time, I'm a complete newbie).
>
> When the modem connection fails (like this morning, I'm in Germany and I
> tried to connect to my ISP; I've clicked on the "modem forces the CD"
> button) the modem no longer works with kPPP. I can open a console, and
> talk to the modem, but kPPP cannot speak to the modem. Whatever I do,
> the log window shows the modem doesn't answer to kPPP (and I've checked
> there is a lock file, so the modem should only be answering to kPPP
> since minicom isn't running).
>
> It's not really a problem, since the modem dials but only in France.
> But, I'd like to be able to connect from Canada or Germany (or whereever
> I may be) so if someone had that problem once, please help.
>
> I've not tried to connect from France, and first (and last) time I
> tried, everything froze. I'll try again, and I've put 'netscape' as
> program to launch on kPPP so perhaps it'll work (?).
>
> Is it possible to write some script I would launch under the console,
> that would connect and make the pppd deamon work, then I would 'startx'
> and use the KDE mail program and netscape communicator? I don't know how
> to to that yet, and my "Linux pour les Nuls" book uses a very different
> way to manage connections to Internet, but when I tried it, I got a
> "unknown command 'CONNECT' so I gave up that method for the moment).
>
> I've tried several commands, to ask the modem to 'ignore the carrier'
> from the phone (the modem waits for a french tone, a continuous 440 Khz
> tone, the A tone in fact for musicians around) and the german one is a
> non-continous tone. I've tried those:
>
> 1. &C0 instead of &C1 (but this should change the way the modem answers
> to the carrier from the modem it's talking to, so this should not be the
> good one).
>
> 2. NC6 ; this one is to tell the modem the country code is 6, that is
> Germany. But the modem didn't react to it.
>
> 3. Xn  I've tried several numbers from 0 to 4 (4 being the minicom
> default). Gave nothing.
>
> 4. Sn=x   I've used S6=1 to tell the modem "wait line before blind
> dialing" but it didn't work either :P
>
> I've browsed some archive at Yellow Dog Linux site, and it looks like
> several people tried using the internal modem of the PowerBook G3. Some
> didn't found it (I found ttyS3) and the messages remained unanswered for most.
>
> --
> Gilbert Fernandes


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

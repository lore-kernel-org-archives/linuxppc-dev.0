Date: Tue, 8 Aug 2000 20:23:54 +0200
From: Olaf Hering <olh@suse.de>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
Message-ID: <20000808202354.B18552@suse.de>
References: <20000808174916.32452@mailhost.mipsys.com> <Pine.SOL.3.95.1000808200844.1384E-100000@juliet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.SOL.3.95.1000808200844.1384E-100000@juliet>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 08, Derek Homeier wrote:

> > >Besides, the keycodes 10 and 50 (less/greater and asciicircum/degree) on
> > >the german keyboard seem to have been swapped in pre13-pre15.
> >
> > Actually, I think it's more that they are now correct (they used to be
> > wrong) ;) You should probably update your keymaps.
> >
> Must have been wrong for quite a while, but I vaguely recall some problems
> with those keys when I first installed Linux (think ^/deg was giving <>
> then, and <> did nothing at all, or vice versa).

Please check it first:

^° should be 50 at console and 58 in X
<> should be 10 at console and 18 in X

Use xev and showkeys to display the values.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

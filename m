Date: Tue, 18 Jul 2000 22:29:47 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: switching consoles
In-Reply-To: <396F59AC.AD522F00@execpc.com>
Message-ID: <Pine.SOL.3.95.1000718222308.3933C-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 14 Jul 2000, Joseph Garcia wrote:

> Derek Homeier wrote:
> > Generally, however, I prefer to set the primary function of the F[1-12]
> > keys to "Function keys" in the "Options" of the "Keyboard" Control Panel.
> > BTW, this seems to be reset whenever my OF variables are set back to defaults.
> > Does anyone know if it is possible to change this setting in OF directly?
>
> I suppose you could try setting it back and forth and getting a hexdump of nvram
> and then diff them to find the common thread.  then write an app that does it
> for you.
>
> Kinda brute force, but thats how I wrote setpramboot and got it working for my
> PDQ. (http://www.execpc.com/~jpgarcia)  The F[1-12] keys thing could be as
> little as a single bit, right?
>
You mean, writing an app that can set it in Linux? Well, would be even
slicker, actually I was only thinking about some OF command like
'setenv keyxxx yyy' to not have to fully boot into MacOS every time the
bootvars are reset. But a linux utility would really be quite useful,
unfortunately I've never played with OF settings from within Linux.
I'll have a look at your setpramboot docs, though.

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

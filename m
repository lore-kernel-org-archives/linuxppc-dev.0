Message-ID: <3ADCDAE5.DF026FAD@iiic.ethz.ch>
Date: Wed, 18 Apr 2001 02:08:05 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
References: <20010418000558.4CD04DBB02@atlas.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> On Tue, Apr 17, 2001, Michel Dänzer wrote:
> > Iain Sandoe wrote:
> [..]
> >> Michel's advice to "option XkbDisable" gives partial functionality (VT
> >> switches, server re-start).... but... with no mouse button emulation or
> >> SysRq. (haven't tried MoL yet).
> >
> > The latter two aren't X but kernel issues.
>
> agreed - so how come installing a new version of X blows them away :-/
> (maybe it's a co-incidence...  hmmm... did I try 2.4.4 _before_ I
> upgraded... can't remember)...
>
> AH! I know what I changed - I've left off the "Xpmac backward compatibility"
> CONFIG option ... should I still use that with XF4 ?

Don't think so. The thing is XF4 doesn't do mouse button emulation, the kernel
does that. For SysRq I suspect that has to do with Linux keycodes?


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

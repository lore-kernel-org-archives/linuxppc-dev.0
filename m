From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: keyboard under XF4?
Date: Mon, 12 Jun 2000 13:37:06 +0200
Content-Type: text/plain
References: <200006121044.MAA03026@piglet.grunz.lu>
In-Reply-To: <200006121044.MAA03026@piglet.grunz.lu>
MIME-Version: 1.0
Message-Id: <00061213370600.00841@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 12 Jun 2000, Michel Lanners wrote:
> Hi list,
>
> This might not really be a -dev issue, but I need help anyway ;-)
>
> I've set up my swiss-french keyboard under XF4; works partly...
>
> What doesn't work is characters I need to type with the <alt> modifier;
> they somehow get 0x80 added to the keysym before it is delivered to an
> app.
>
> xev shows the correct charcter map, keysym etc. However, it's wrong once
> it appears in eg. an xterm: hitting <alt>3 should produce '#' (keysym
> 0x23), but in xterm the result is '£' (keysym 0xa3).
>
> Any idea? FWIW, I'm using xmodmap to set the mapping under X. Also,
> console is OK, so it's really an X issue...

Well, I have no idea what's going on for you, but I can tell you that Ben,
Olaf and me are working on a keyboard patch for 2.2.17 that will make us
mostly compatible with the usual PC keymaps for X. The kludges
(MEDIUMRAW/keymap) for PPC in XF4 will hopefully go away in 4.01, but
definetly in 4.02 then. Keep an eye on the linux-pmac-benh tree during the
next week.

The whole thing already works fine for me with USB/ADB keyboards in "new"
mode with a clean XF4, I'm currently working on the backwards compatibility
stuff for xpmac.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

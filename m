From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Keyboard trouble with XF 4.0.1
Date: Sun, 22 Oct 2000 20:45:30 +0200
Message-Id: <19340916121714.14652@192.168.1.10>
In-Reply-To: <200010221630.SAA01006@piglet.grunz.lu>
References: <200010221630.SAA01006@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Second, my Alt'ed or Shift-Alt'ed keys still don't work. Under Linux
>keycodes, there is no difference whether Alt is pressed or not; the
>resulting key is the same, and xev shows the same old keycode as without
>Alt.

Yup, my old french keymaps broke with XF4.0.1 too. I hacked something
that more or less works by changine some of the modifier definitions.
I'll send you my keymap in a separate email once I have it at hand. I
can't say I understood XKB however ;)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

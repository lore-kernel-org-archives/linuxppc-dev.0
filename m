Date: Tue, 28 Sep 1999 15:48:33 +0200
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Keyboard problewm
Message-Id: <19990928154833.028330@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

There is a problem with current pmac kernels which I've not been able to
fix so far, the keyboard code in the kernel is still beyond my understanding.

Basically, the problem if whatever you define in your userland keymaps
(console keymap or X keymap), the alt-shift-key combos never work. That's
annoying since french keyboards use them extensively for things like "|"
or "\". We can still remap them to something else, but it's less
consistent with MacOS behaviour.

This used to work, a long time ago. I remember this was broken, I think,
near the end of 2.1.xxx or the beginning of 2.2.x. According to various
users reports here in France, for some time, vger kernels still worked
while Paul trees were broken until the "feature" got merged from Paul to vger.

The keycodes for option and shift are correctly forwarded to userland in
raw mode, the problem seems to be with translation. But I really don't
know how the h... this translation stuff works.

Any clues ?


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

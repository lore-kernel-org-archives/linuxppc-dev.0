From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Subject: Re: Keycodes for the new input layer
Date: Thu, 13 Jul 2000 01:29:33 +0200
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9LYL3ZFZOOTHTQO9XNYK"
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.SOL.3.95.1000712143953.21439H-100000@juliet>
In-Reply-To: <Pine.SOL.3.95.1000712143953.21439H-100000@juliet>
MIME-Version: 1.0
Message-Id: <00071301293300.05612@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_9LYL3ZFZOOTHTQO9XNYK
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

On Wed, 12 Jul 2000, Derek Homeier wrote:
> On Wed, 12 Jul 2000, Franz Sirl wrote:
> > The problem here is that newer Apple keyboards additionally label OptionL
> > as ALT and 3rd party keyboards with an additional OptionR label it as
> > ALTGR, which pretty much limits the correct choices :-(. Anyway, I'll put
> > keymap .inc files into console-tools that let you easily change it (eg.
> > option-left-as-alt.inc, command-leftright-as-altgr.inc, etc.).
>
> I see. Which of these is equivalent to the old single Option key?

optionL-as-alt + commandLR-as-altgr probably. It's in the new console-tools
package I have on devel now.

> Personally, I'd like something different for both, so they could be
> independently bound to the mousebuttons. If one wanted to use it as
> KP_Enter, it could probably still be bound in the console and xkb
> keymaps? I've no idea for a name, though. I think with the older kernels
> it was just NoKey (and couldn't be bound to any Key Symbol, but to the
> mousebuttons). KEY_LINEFEED, perhaps?
>
>  Fn-RET = KEY_KPENTER
>  _^ = KEY_KPENTER
>   Fn-_^ = [something different]
>
> would probably also be o.k., though.

How about the appended patch?

Franz.

--------------Boundary-00=_9LYL3ZFZOOTHTQO9XNYK
Content-Type: text/x-c;
  name="kbd6-ben1-9.patch"
Content-Disposition: attachment; filename="kbd6-ben1-9.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LXBtYWMtYmVuaC9kcml2ZXJzL21hY2ludG9zaC9tYWNfa2V5Yi5jCVRodSBKdWwg
MTMgMDA6MjM6MzcgMjAwMAorKysgbGludXgtcG1hYy1iZW5oLWZyYS9kcml2ZXJzL21hY2ludG9z
aC9tYWNfa2V5Yi5jCVRodSBKdWwgMTMgMDE6MTg6MjEgMjAwMApAQCAtMjYwLDEwICsyNjAsMTAg
QEAgdW5zaWduZWQgY2hhciBhZGJfdG9fbGludXhfa2V5Y29kZXNbMTI4XQogCSAzMCwgMzEsIDMy
LCAzMywgMzUsIDM0LCA0NCwgNDUsIDQ2LCA0NywgODYsIDQ4LCAxNiwgMTcsIDE4LCAxOSwKIAkg
MjEsIDIwLCAgMiwgIDMsICA0LCAgNSwgIDcsICA2LCAxMywgMTAsICA4LCAxMiwgIDksIDExLCAy
NywgMjQsCiAJIDIyLCAyNiwgMjMsIDI1LCAyOCwgMzgsIDM2LCA0MCwgMzcsIDM5LCA0MywgNTEs
IDUzLCA0OSwgNTAsIDUyLAotCSAxNSwgNTcsIDQxLCAxNCwgIDAsICAxLCAyOSwxMjUsIDQyLCA1
OCwgNTYsMTA1LDEwNiwxMDgsMTAzLCAgMCwKKwkgMTUsIDU3LCA0MSwgMTQsIDk2LCAgMSwgMjks
MTI1LCA0MiwgNTgsIDU2LDEwNSwxMDYsMTA4LDEwMywgIDAsCiAJICAwLCA4MywgIDAsIDU1LCAg
MCwgNzgsICAwLCA2OSwgIDAsICAwLCAgMCwgOTgsIDk2LCAgMCwgNzQsICAwLAogCSAgMCwxMTcs
IDgyLCA3OSwgODAsIDgxLCA3NSwgNzYsIDc3LCA3MSwgIDAsIDcyLCA3MywxMjQsIDg5LCAgMCwK
LQkgNjMsIDY0LCA2NSwgNjEsIDY2LCA2NywgNDEsIDg3LDExMiwgOTksICAwLCA3MCwgIDAsIDY4
LCAgMCwgODgsCisJIDYzLCA2NCwgNjUsIDYxLCA2NiwgNjcsIDQxLCA4NywxMTIsIDk5LCAgMCwg
NzAsICAwLCA2OCwxMDEsIDg4LAogCSAgMCwxMTksMTEwLDEwMiwxMDQsMTExLCA2MiwxMDcsIDYw
LDEwOSwgNTksIDU0LDEwMCwgOTcsMTE2LDExNgogfTsKIAo=

--------------Boundary-00=_9LYL3ZFZOOTHTQO9XNYK--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

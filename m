Date: Wed, 18 Apr 2001 01:06:07 +0100
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michel D=?ISO-8859-1?B?5A==?=nzer" <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Message-Id: <20010418000558.4CD04DBB02@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 17, 2001, Michel Dänzer wrote:
> Iain Sandoe wrote:
[..]
>> Michel's advice to "option XkbDisable" gives partial functionality (VT
>> switches, server re-start).... but... with no mouse button emulation or
>> SysRq. (haven't tried MoL yet).
>
> The latter two aren't X but kernel issues.

agreed - so how come installing a new version of X blows them away :-/
(maybe it's a co-incidence...  hmmm... did I try 2.4.4 _before_ I
upgraded... can't remember)...

AH! I know what I changed - I've left off the "Xpmac backward compatibility"
CONFIG option ... should I still use that with XF4 ?

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

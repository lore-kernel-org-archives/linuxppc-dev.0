Message-Id: <200009222256.XAA19068@hyperion.valhalla.net>
Date: Fri, 22 Sep 2000 23:56:37 +0100
Subject: Re: Linux keycodes and left cursor on Pismo
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Henry Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Also, what is the key combination for the Magic Sysrq on a Pismo?
>>
>
> For xmon it's <cmd><Power>.

Hmmm. <cmd> <power> is the xmon interrupt key (certainly on the G3 (ADB
Kbd)) - it isn't, however, the magic SysRq key.


>I'm not sure the Linux SysReq facility is supported for PPC, I've never seen it
enabled in Ben's .config files and there is no sign of it in the archives.

SysRq is supported under PPC linux.

SysRq works fine on G3 and it is <cmd> or <alt> <f13> (duh... I forget which
and am not on that machine right now)...

if you grep for it in the kernel tree you can find the code (and change it
if you like).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39CBD3D0.C7F1964A@wanadoo.fr>
Date: Fri, 22 Sep 2000 23:49:04 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Henry Worth <haworth@ncal.verio.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux keycodes and left cursor on Pismo
References: <Pine.SOL.4.10.10009221556010.17778-100000@ncal.verio.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henry Worth wrote:
>
> Michel Dänzer <daenzerm@student.ethz.ch> wrote:

> >Also, what is the key combination for the Magic Sysrq on a Pismo?
> >
>
> For xmon it's <cmd><Power>. I'm not sure the Linux SysReq facility
> is supported for PPC, I've never seen it enabled in Ben's .config
> files and there is no sign of it in the archives.

F13 (keycode 0x69) works for me as MagicSysRq (ADB keyboard, kernels
2.2.x or 2.4.0-x).

> However, invoking xmon once X (at least Xpmac 10) is running
> will result in a microscopic xmon text session replicated 4 times
> across the screen (even if you switch back to a text VT first).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

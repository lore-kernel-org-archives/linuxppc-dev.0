Message-ID: <69AB2E42243FD511920200805FE64EAD0E36CF@zbr01exm01.spo.br.mot.com>
From: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>
To: "'gao xiaoguo'" <gaoxg@guoguang.com.cn>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: monitor in mpc860fads
Date: Tue, 26 Feb 2002 09:00:10 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Fads boards don't have any native monitor. You need to flash one on your board.
If you intend to run Linux on your fads, I recommend you using ppcboot as bootloader.

You can find ppcboot at http://ppcboot.sourceforge.net
Also, take a look at the "Linux for PowerPC embedded Systems Howto" at http://penguinppc.org/embedded/howto/PowerPC-Embedded-HOWTO.html. That is a very good guide.

regards

Evandro

> -----Original Message-----
> From: gao xiaoguo [mailto:gaoxg@guoguang.com.cn]
> Sent: Terça-feira, 26 de Fevereiro de 2002 06:17
> To: linuxppc-embedded
> Subject: monitor in mpc860fads
>
>
>
> hi,
>
> now i have a mpc860fads board, maybe there is a debug monitor
> inside it.
> but i dont know how to check it. i also dont know what i need
> on host end to communicate with the monitor. some guide book
> is appreciated.
>
> I am newbie in this area, hope some expertise point out a way for me.
>
> thanks
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

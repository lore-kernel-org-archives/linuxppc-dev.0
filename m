Message-ID: <3C7B8BD8.5FE5DCB6@opensource.se>
Date: Tue, 26 Feb 2002 14:21:28 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>
Cc: "'gao xiaoguo'" <gaoxg@guoguang.com.cn>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: monitor in mpc860fads
References: <69AB2E42243FD511920200805FE64EAD0E36CF@zbr01exm01.spo.br.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> If you intend to run Linux on your fads, I recommend you using ppcboot as bootloader.

A more minimalistic approach would be Miniboot. =)

http://opensource.se/projects/miniboot

The FADS board is supported right out of the box.
Just make sure you use the right crystal.

You could then boot PPCBoot from Miniboot if you want network support,
etc.

/ magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

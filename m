Date: Fri, 06 Apr 2001 07:51:48 +0100
Subject: Re: DMASOUND->rev6 (2.4.3)(attn: Xine, MOL, PowerComputing, ibook,
	  Tumbler)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Henry Worth <haworth@ncal.verio.com>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010406065139.D7795DBA1A@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Henry,

> Applied to 2.4.3-benh, it is still reporting back 48K.

>
> In case I've got the wrong level:

'fraid so...

> PowerMac (AWACS rev 3 [screamer])  DMA sound driver rev 016 installed
> Core driver edition 01.05 : PowerMac Built-in Sound driver edition 00.05
                        ^^^                                            ^^^
the fixes are in in 1.06          0.06

- you  need to apply *both* posted patches -final first and then -to-rev6
(or try the binaries).

ciao,
Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200210221309.PAA17574@ipnmail.in2p3.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Grave <grave@ipno.in2p3.fr>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 15:06:41 +0200
References: <200210221136.NAA12538@ipnmail.in2p3.fr> <20021022150035.4279@192.168.4.1>
In-Reply-To: <20021022150035.4279@192.168.4.1>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 22 October 2002 17:00, Benjamin Herrenschmidt wrote:
> >Work fine now, using vmlinux + the option video=ofonly.
> >
> >Great to use two processors !
>
> What video card do you have ? It doesn't work without
> video=ofonly ? It's a radeon or nVidia ? Can you
> send me the lspci -vv output (as root)

It's seems to be a RADEON 9000.
No succes with the actual xfree version :-(

[root@ipnnarval ~]# lspci -s 00:10.0 -vv
00:10.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4966
(rev 01) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 4966
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at 98000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 802400 [disabled] [size=256]
        Region 2: Memory at 90000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 90020000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

To: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Permedia2 fb on PPC
References: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
	<1007572780.21734.65.camel@pismo>
	<wrpadwxth3m.fsf@hina.wild-wind.fr.eu.org>
	<1007848074.9125.10.camel@pismo>
Reply-To: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 08 Dec 2001 23:41:39 +0100
Message-ID: <wrpr8q5baho.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <1007848074.9125.10.camel@pismo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Michel" == Michel Dänzer <michdaen@iiic.ethz.ch> writes:

Michel> And does it work with the XFree86 glint driver with Option
Michel> "UseFBDev"?
>>
>> Don't know yet. _Now_ that I have a console (thanks to this patch),
>> I'll have a look at the X11 thingy.

Michel> Well at least when I last worked on the glint driver, it
Michel> relied on the register aperture being big endian.

Indeed, glint driver doesn't work with UseFBDev.

Could this be a chipset issue (3DLabs vs TI) ? Mine is a Texas
Instrument (aka ti_pm2) :

00:0d.0 Display controller: Texas Instruments TVP4020 [Permedia 2] (rev 01)
        Subsystem: Texas Instruments TVP4020 [Permedia 2]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (48000ns min, 48000ns max)
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at 80840000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at 81000000 (32-bit, non-prefetchable) [size=8M]
        Region 2: Memory at 90000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at 80800000 [disabled] [size=64K]

Any idea ?

        M.
--
Places change, faces change. Life is so very strange.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

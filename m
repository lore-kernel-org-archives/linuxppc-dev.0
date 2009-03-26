Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id B374ADDDA1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 00:56:51 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Lmq4e-0006G2-Ow
	for linuxppc-dev@ozlabs.org; Thu, 26 Mar 2009 06:56:48 -0700
Message-ID: <22722574.post@talk.nabble.com>
Date: Thu, 26 Mar 2009 06:56:48 -0700 (PDT)
From: rizwan ahmad <rizwanamu@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: sata device failed to IDENTIFY...
In-Reply-To: <22655709.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <22655709.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




output of lspci -vv

-bash-3.2# lspci -vv
00:0c.0 Class 0c03: Unknown device 1106:3038 (rev 62)
        Subsystem: Unknown device 1106:3038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Ste-        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor-        Latency: 128
        Interrupt: pin A routed to IRQ 25
        Region 4: I/O ports at ffe0 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3)                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:0c.1 Class 0c03: Unknown device 1106:3038 (rev 62)
        Subsystem: Unknown device 1106:3038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Ste-        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor-        Latency: 128
        Interrupt: pin B routed to IRQ 25
        Region 4: I/O ports at ffc0 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3)                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:0c.2 Class 0c03: Unknown device 1106:3104 (rev 65) (prog-if 20)
        Subsystem: Unknown device 1106:3104
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Ste-        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbor-        Latency: 128
        Interrupt: pin C routed to IRQ 25
        Region 0: Memory at afffff00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3)                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:0c.3 Class 0104: Unknown device 1106:3249 (rev 50)
        Subsystem: Unknown device 1106:3249
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Ste-        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbor-        Latency: 128
        Interrupt: pin A routed to IRQ 25
        Region 0: I/O ports at ffb0 [size=16]
        Region 1: I/O ports at ffa0 [size=16]
        Region 2: I/O ports at ff90 [size=16]
        Region 3: I/O ports at ff80 [size=16]
        Region 4: I/O ports at ff60 [size=32]
        Region 5: I/O ports at fe00 [size=256]
        Expansion ROM at <ignored> [disabled]
        Capabilities: [e0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3ho)                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

-bash-3.2#



-- 
View this message in context: http://www.nabble.com/sata-device-failed-to-IDENTIFY...-tp22655709p22722574.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.

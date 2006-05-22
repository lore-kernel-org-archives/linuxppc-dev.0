Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id D41B467A5B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 06:59:03 +1000 (EST)
Message-ID: <00f901c67de2$865e0f70$6501a8c0@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Evan Cofsky" <evan@theunixman.com>,
	<linuxppc-embedded@ozlabs.org>
References: <20060522200248.GG341278@valinor.arda.theunixman.com>
Subject: Re: BDI 2000 and MPC 8250 Problem
Date: Mon, 22 May 2006 16:58:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> I'm experiencing the following error with a BDI 2000 connected to the
> JTAG port on a A&M Rattler 8250 board.  I was wondering if this is a
> hardware problem, or if I have the wrong configuration set up.  The
> following are a telnet session transcript, the BDI configuration file,
> and the register configuration file.
> 
> Thanks
> 
> BDI Telnet Session Transcript (repeats endlessly):
> 
> - TARGET: processing user reset request
> *** TARGET: resetting target failed
> # PPC: unexpected response from target
> - TARGET: target will be restarted in 10 sec
> 
> rattler8250pci.cfg:
> 
> ;bdiGDB configuration file for rattler
> ; ------------------------------------------------------
> ;
> [INIT]
> ;WREG    MSR             0x00001002      ; set up MSR
> ;WSPR    1008            0               ; turn off caches
 === > > WM32    0x000101A8      0x00f00000      ; IMMR == 0xFF000000

Type, or are you setting IMMR to 0xf0000000 ?

To: Marco Schramel <Schramel.Linux@go.bartec.de>
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI kernel debug 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 06 Jul 2004 13:31:08 +0200."
             <200407061331.08613.Schramel.Linux@go.bartec.de>
Date: Tue, 06 Jul 2004 20:18:26 +0200
Message-Id: <20040706181831.52416C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200407061331.08613.Schramel.Linux@go.bartec.de> you wrote:
>
> i have some problems with debugging my kernel. This is the first time i use bdi for kernel debugging. ELDK 3.0 is my toolchain (Target 8270).
...
> Are there some options in the kernel or in the gdb to set ?

Did you enable CONFIG_DEBUG_KERNEL in your kernel configuration?

Did you read the FAQ section of the DULG, especially
http://www.denx.de/twiki/bin/view/DULG/HowToDebugLinuxExceptions
and
http://www.denx.de/twiki/bin/view/DULG/HowToSingleStepThroughRFIInstruction

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Death, when unnecessary, is a tragic thing.
	-- Flint, "Requiem for Methuselah", stardate 5843.7

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

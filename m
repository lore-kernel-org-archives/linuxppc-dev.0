To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ATAG for MAC address??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 06 Jul 2004 10:57:58 +0200."
             <40EA6996.1010402@imc-berlin.de>
Date: Tue, 06 Jul 2004 11:55:39 +0200
Message-Id: <20040706095544.DBC29C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40EA6996.1010402@imc-berlin.de> you wrote:
>
> could we introduce an ATAG_MAC or ATAG_ETH_MAC so we can pass the MAC
> address for the ethernet controller from the boot loader to the linux kernel
> using the ATAG mechanism?
>
> I don't want to pass "MAC=..." as a commandline though.

Linux does not use any ATAGs on PowerPC.

Wrong list?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Linux - Why use Windows, since there is a door?
       -- Alain Knaff in <slrn50c2o5.auk.knaff@choiseul.inrialpes.fr>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

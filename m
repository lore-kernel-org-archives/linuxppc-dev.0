From: "Elan Feingold" <elan@nxnetworks.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: kernel hangs at my_console_write
Date: Mon, 6 Aug 2001 11:36:57 -0500
Message-ID: <NDBBLJLFCLLGDHJPGKGCKEBPEDAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3A494DE356A49A40B37442E1E0D9F3B5063406@ptah.ad.newisys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I am using the Hardhat 1.2 kernel from MVista on my custom board with
> MPC855T. The kernel executes and hangs at my_console_write routine.

We were using a slightly different kernel (2.4.5 + patches), but we saw a
hang in console_write when we didn't have our Baud Rate Generator clock
frequency correct.  In the version we were using, the numbers in
embed_config() seemed to indicate that Hz were desired, but after grepping
around, we saw that some parts of the kernel wanted Mhz.  Once we fixed
that, we got console output and things worked.

Hope this helps,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

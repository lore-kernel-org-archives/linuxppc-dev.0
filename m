Message-ID: <3E4FC683.60403@embeddededge.com>
Date: Sun, 16 Feb 2003 12:12:35 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: panto133@otenet.gr
Cc: Pantelis Antoniou <panto@intracom.gr>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: [2.5] Hang on 8xx in head_8xx.S
References: <3E4B9D4E.7080808@intracom.gr> <3E4CF810.8040803@intracom.gr> <3E4D5209.30802@embeddededge.com> <200302142330.59987.panto133@otenet.gr>
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou wrote:

> The drivers are assuming that you use only one
> peripheral of each kind. That is yoy have a
> UART in SCC1, ethernet in SCC3 and so on.

I don't quite understand.  The uart driver will support a
variety of SMC/SCC combinations.

We have discussed before that we are not doing "scc" or "smc"
drivers, but rather "uart", "ethernet", "usb", whatever function
driver.  It doesn't make sense to have an 'scc' driver because
there are so many configuration combinations and you logically
connect to the kernel with a function (i.e. network interface)
not a device type.

> There are some configurations that require
> more than one of each kind, for example two
> ethernets.

Well, in the case of multiple SCC ethernets, I have provided my old
patch to probably a half a dozen people, all who promised to
bring it up to date and apply some suggested improvements.  None
of them have provided anything up to date in return, so I guess
I'll have to take time to do that, too :-)  The 8260 FCC driver
supports any combination of FCC Ethernet devices.


Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <40A4E33F.9070506@intracom.gr>
Date: Fri, 14 May 2004 18:18:23 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>, Wolfgang Denk <wd@denx.de>,
	sanjeevr@myw.ltindia.com
Subject: Re: [PATCH] Driver for FECs on motorola DUET (87x/88x)
References: <JPEALJAFNGDDLOPNDIEEOEHHCIAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <JPEALJAFNGDDLOPNDIEEOEHHCIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

>>From: Pantelis Antoniou [mailto:panto@intracom.gr]
>>
>>Progress report.
>>
>>Got it to move even further.
>>
>
>Great!
>
>
:P

>>No longer crashes but it seems stuck in something related
>>to the serial console.
>>
>
>If you are going to mess with the 8xx_io/uart.c, you might
>want to port this from 2.4:
>http://ppc.bkbits.net:8080/linuxppc-2.4/diffs/arch/ppc/8xx_io/uart.c@1.14.1.9?nav=index.html|src/.|src/arch|src/arch/ppc|src/arch/pp
>c/8xx_io|hist/arch/ppc/8xx_io/uart.c
>
>
>
>
I know, I tried to port it over but it's a mess.
Things have changed dramatically in the serial subsystem in 2.6.

I'm not sure that I will avoid rewritting the serial driver.

Regards

Pantelis


Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <75DF04AC5ED4D511A9810090273CB4163F5DED@rokonet-e.rokonet.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx SCC's as uart
Date: Sun, 20 Jul 2003 10:52:01 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Dan,

Originally I was referring to both kernel.org and Denx.  But I was referred
to a patched 2.4.20 version from Denx that enables SCC1 and SCC4 as uarts
including RTS, CTS, DCD and DTR pin configuration.

I believe this should go into the kernel from kernel.org.  If one chooses to
use the 860(T/DT) or 855(T) processors why shouldn't he use SSC1 and 4 as
uarts.  The limitation of the 857 should not limit other processors.  Look
at the 852(T), it can use SCC4 as a uart.

Regarding the baud rate generators, we can configure the to more then one
uart, if those uarts use the same baud rate.  So, perhaps the BRG's should
be decoupled from the uart in the configuration.  This will go to the 8xx
CPM configuration witch is processor specific in the first place (FEC, SCC
and Ethernet and other 8xx processor variant stuff).

Thank you,
Eli Brin



-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Friday, July 18, 2003 6:28 PM
To: Eli Brin
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: 8xx SCC's as uart


Eli Brin wrote:

> I have noticed, in kernel 2.4.20, that SCC1 and SCC4 cannot be
> configured as uarts.

Ummmm....2.4.20 from where?

The linuxppc 2.4 development tree was updated by Gary Thomas a while back to
allow all possible SMC/SCC configurations within the resource limitations of
the particular processor variant.  This included the baud rate generator
restrictions on the 857.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <38FB0DA0.DDE9098C@embeddededge.com>
Date: Mon, 17 Apr 2000 09:12:00 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Bizarre initrd problem on CLLF860T
References: <20000417070226.92BE33C961@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> Today though, I can't for the life of me work out why the initrd stuff isn't
> working.

So, what's different in your configuration?  Is this the same kernel
and ramdisk?  Like I requested in a previous message, the the sources
from MontaVista.  They are the most recent.


> Sending BOOTP requests..... OK
> IP-Config: Got BOOTP answer from 10.2.2.90, my address is 10.2.0.21
> IP-Config: Guessing netmask 255.0.0.0
> RAMDISK: Compressed image found at block 0

IP-Config with Ramdisk is a pretty weird configuration.  At the
'Linux/PPC Load:' enter 'root=/dev/ram ip=off'.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

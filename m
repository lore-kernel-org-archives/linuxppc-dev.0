Message-ID: <39C97532.3A0ADE15@mvista.com>
Date: Wed, 20 Sep 2000 22:40:50 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: Roman Zippel <zippel@fh-brandenburg.de>, paulus@linuxcare.com.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <200009210226.WAA27782@mal-ach.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:

> ......  The mis-optimization
> is PowerPC Linux-specific, this is not a general Linux kernel or Linux VM
> problem.

Really (seriously)?  I always thought if the Linux VM used a different
structure and method of accessing page tables (upper entries are more
than just a software address pointer for example), we could really
optimize the PowerPC kernel.

Toss out some ideas......I'm listening :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

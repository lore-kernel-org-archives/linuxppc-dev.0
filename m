Message-ID: <39C96F6D.32DAD47D@mvista.com>
Date: Wed, 20 Sep 2000 22:16:13 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: Roman Zippel <zippel@fh-brandenburg.de>, paulus@linuxcare.com.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <200009202041.QAA25046@mal-ach.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:

>         Avoiding the hash table on PowerPC only is an advantage because
> the PowerPC Linux kernel implements some "optimizations" which do not
> match the PowerPC architecture very well.

Right....I thought I clearly said "Linux VM".  If the main platform of
focus and development was PowerPC (although I thought it was :-), the
Linux VM subsystem would look a little different....


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39C8FDDC.29AEDE52@mvista.com>
Date: Wed, 20 Sep 2000 14:11:40 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: paulus@linuxcare.com.au, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.GSO.4.10.10009200217400.11866-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> Hmm, I think I have to order some new documentation. :-)
> What are some important cpus I should look into (except 60x)?

None of the embedded PowerPCs use a hash table, and the Book E
processors don't either.  We avoid using the hash table when given
the option, like 603s.  The "hardware assist" and subsequent hash
table is a PITA for Linux VM, and Cort has documented the performance
benefits of not using it.


	-- Dan
--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

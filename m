Message-Id: <200009202041.QAA25046@mal-ach.watson.ibm.com>
To: Dan Malek <dan@mvista.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>, paulus@linuxcare.com.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2 
In-Reply-To: Message from Dan Malek <dan@mvista.com>
   of "Wed, 20 Sep 2000 14:11:40 EDT." <39C8FDDC.29AEDE52@mvista.com>
Date: Wed, 20 Sep 2000 16:41:03 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Dan Malek writes:

Dan> None of the embedded PowerPCs use a hash table, and the Book E
Dan> processors don't either.  We avoid using the hash table when given
Dan> the option, like 603s.  The "hardware assist" and subsequent hash
Dan> table is a PITA for Linux VM, and Cort has documented the performance
Dan> benefits of not using it.

	Avoiding the hash table on PowerPC only is an advantage because
the PowerPC Linux kernel implements some "optimizations" which do not
match the PowerPC architecture very well.  Avoiding the hash tables
recovers some of the performance lost because of the earlier work, so it
is a relative benefit but not an absolute benefit over a better kernel
design.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

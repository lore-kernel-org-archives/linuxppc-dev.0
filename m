Message-Id: <200009210226.WAA27782@mal-ach.watson.ibm.com>
To: Dan Malek <dan@mvista.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>, paulus@linuxcare.com.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2 
In-Reply-To: Message from Dan Malek <dan@mvista.com>
   of "Wed, 20 Sep 2000 22:16:13 EDT." <39C96F6D.32DAD47D@mvista.com>
Date: Wed, 20 Sep 2000 22:26:26 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Apparently I was too ambiguous in my reply.  The mis-optimization
is PowerPC Linux-specific, this is not a general Linux kernel or Linux VM
problem.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

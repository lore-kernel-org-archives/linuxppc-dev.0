Message-Id: <200102082317.SAA27866@mal-ach.watson.ibm.com>
To: Cort Dougan <cort@fsmlabs.com>
Cc: paulus@linuxcare.com.au, Dan Malek <dan@mvista.com>,
	Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
	linuxppc-commit@hq.fsmlabs.com,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: Message from Cort Dougan <cort@fsmlabs.com>
   of "Thu, 08 Feb 2001 15:26:42 MST." <20010208152641.P24312@hq.fsmlabs.com>
Date: Thu, 08 Feb 2001 18:17:31 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I do not know which version of AIX you were testing and exactly
how your benchmarks were stressing the system.  AIX continually is
improving, just as is the Linux kernel.  As I said, the your design was
very good for the particular class of PowerPC implementation that you were
targetting.  AIX normally is tuned for a different class of processors and
system configurations than Linux has targeted, so I would not expect them
to have the same sweet spot when running benchmarks.

	We currently are in the process of writing some papers about the
system which should explain some of the design decisions.  We very much
want to help improve the PowerPC Linux kernel VMM design and interact with
you and other developers.  After the current papers are done, we will have
more time to engage in discussions about this.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

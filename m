Date: Thu, 8 Feb 2001 15:26:42 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: David Edelsohn <dje@watson.ibm.com>
Cc: paulus@linuxcare.com.au, Dan Malek <dan@mvista.com>,
	Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
	linuxppc-commit@hq.fsmlabs.com,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
Message-ID: <20010208152641.P24312@hq.fsmlabs.com>
References: <cort@fsmlabs.com> <200102082208.RAA22218@mal-ach.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200102082208.RAA22218@mal-ach.watson.ibm.com>; from David Edelsohn on Thu, Feb 08, 2001 at 05:08:32PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


} statements about which VMM design is best.  You can create a wonderful
} engineer solution, but are you solving the problem or simply masking a
} symptom?

Would you characterize AIX as an OS that takes advantage of the VMM design
of the PowerPC?  From the benchmarks I did it appeared to suffer the same
problem that Linux/PPC did at that time.  The problem being, a
straightforward implementation of the software side of the VM design of the
PowerPC.  After some general improvements in the MM system of Linux/PPC we
sped things up by a large amount by doing what you claim is a mistake.  We
widened the gap between Linux/PPC and what was probably the best example of
what VM design can come from knowledge of the PPC architecture (in AIX).

AIX can't claim to be doing it better.  I was unable to look under the hood
of AIX, of course, but my benchmarks did show that the _ONLY_ thing that
mattered - wall clock time of user apps - was improved.  Doing things that
non-PPC way is not a flaw if it results in better performance.

I do stand by our design, and the choices we made, but I'm open to
suggestion for better ways to do it.  I can certainly believe there's a lot
of room for improvement.  This is linux, though - actual working code speaks
more loudly and clearly than anything else.

Do you have an example of a better way of doing a VM system in Linux/PPC?
We can't change the page table layout.  That's something we're stuck with,
in one form or another, in Linux no matter what (not our decision).  What
does Kitchewan do for a VM subsystem?  Can you give me an overview of the
design?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16080.45237.64314.364407@argo.ozlabs.ibm.com>
Date: Sun, 25 May 2003 22:01:57 +1000
To: akuster@mvista.com, Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: GPL inconsistency in arch/ppc/ocp/xlinx/
In-Reply-To: <20030524201213.GA8256@lst.de>
References: <20030524201213.GA8256@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christoph Hellwig writes:

> you seem to have added the the directory in the topic to the LinuxPPC
> trees.  Unfortunately they have a license consitency that basically
> makes them illegal to distribute, they claim to be under GPL but have
> the following notice:
>
> *     Xilinx products are not intended for use in life support appliances,
> *     devices, or systems. Use in such applications are expressly prohibited.
>
> Could you please contact Xilinc to clarify the license and/or remove
> those files from the tree?  Thanks.

It would depend on whether those files are a "Xilinx product" or not.
I would take that statement as normally applying to the hardware they
produce (i.e. their FPGAs).  I agree it needs to be clarified though.

I also notice that their statement in upper case just above that says
that you are responsible for obtaining any rights you may require for
your implementation, which could be seen as conflicting with the
patent grant section of the GPL.

Armin, could you ask Xilinx if they would mind clarifying these two
points?  Perhaps they could add a statement saying that if any of
those terms conflict with the GPL then the GPL is to prevail - although,
the best thing would be to remove the extra paragraphs, since the GPL
covers the disclaimer of warranty, patent concerns, etc. already.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: u64 fun and PCI DMA not working for things behind bridges?
References: <Pine.LNX.4.30.0103011305510.28644-100000@opal.biophys.uni-duesseldorf.de>
From: Daniel Berlin <dberlin@redhat.com>
Date: 01 Mar 2001 10:06:07 -0500
In-Reply-To: <Pine.LNX.4.30.0103011305510.28644-100000@opal.biophys.uni-duesseldorf.de> (Michael Schmitz's message of "Thu, 1 Mar 2001 13:06:30 +0100 (CET)")
Message-ID: <m2hf1dy1eo.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> writes:

> > I can't compile the drivers without optimization, or else i get
> > references to functions that don't exist in the kernel, for some
> > reason.
>
> What exact functions don't exist?
>
> 	Michael

Any extern inline functions.

--Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

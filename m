Date: Wed, 17 Feb 1999 13:19:31 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <Pine.LNX.3.96.990216125317.30556A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.990217131308.26713D-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 16 Feb 1999, Cort Dougan wrote:

> Not quite.  Just chrp/prep/pmac (and soon apus I hope).  I want a single
> kernel for the desktop to avoid recompiles when testing out kernels.  Ram
> isn't a big deal on these machines (a few K for a generic kernel isn't a
> big deal anyway).  The performance loss is negligible as well (it can be
> improved though).  Other boards (especially embedded) can't do this - it
> would be insane :)  Those will be compiled specifically for the target
> architecture.

I had the impression that the APUS I/O accesses had to use non byte
swapped instruction, so that merging the APUS with the other would be
hard. Is there something I missed ? 

I don't want the kernel to execute conditional code or to call a
subroutine for every I/O access, this is bloat and/or inefficiency for
the sake of it. 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

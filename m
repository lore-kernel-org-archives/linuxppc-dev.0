Date: Wed, 10 Oct 2001 12:24:15 -0600
From: Val Henson <val@nmt.edu>
To: linuxppc-dev@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: SBS Palomar II/IV/V port
Message-ID: <20011010122415.A22918@boardwalk>
References: <0110092125.AA22665@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0110092125.AA22665@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Tue, Oct 09, 2001 at 02:25:03PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 09, 2001 at 02:25:03PM -0700, Michael Sokolov wrote:

> Some other bi_rec fixes may be needed (initrd ones are broken I think).

Indeed!  This is on my list of stuff to do - straighten out once and
for all how BI_INITRD works and then rewrite the Gemini boot process
to use it.  It seemed like we had two interpretations:

1. The BI_INITRD boot record contains the start address and the size
   of the initrd.

2. The BI_INITRD boot record contains the entire initrd itself (as a
   really large boot record).

I have no preference either way, I just want someone to tell me which
way we're going to do it. :)

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15300.57440.671519.38318@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2001 09:57:20 +1000 (EST)
To: Val Henson <val@nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SBS Palomar II/IV/V port
In-Reply-To: <20011010122415.A22918@boardwalk>
References: <0110092125.AA22665@ivan.Harhan.ORG>
	<20011010122415.A22918@boardwalk>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Val Henson writes:

> 1. The BI_INITRD boot record contains the start address and the size
>    of the initrd.
>
> 2. The BI_INITRD boot record contains the entire initrd itself (as a
>    really large boot record).
>
> I have no preference either way, I just want someone to tell me which
> way we're going to do it. :)

I think 1 is preferable, if you have 1 you can actually do 2 as well
in fact (just have a large record with an address/size record at the
front with the address pointing into the record).

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

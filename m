Date: Wed, 10 Oct 2001 18:06:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: SBS Palomar II/IV/V port
Message-ID: <20011010180622.B11067@cpe-24-221-152-185.az.sprintbbd.net>
References: <0110092125.AA22665@ivan.Harhan.ORG> <20011010122415.A22918@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011010122415.A22918@boardwalk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 10, 2001 at 12:24:15PM -0600, Val Henson wrote:
>
> On Tue, Oct 09, 2001 at 02:25:03PM -0700, Michael Sokolov wrote:
>
> > Some other bi_rec fixes may be needed (initrd ones are broken I think).
>
> Indeed!  This is on my list of stuff to do - straighten out once and
> for all how BI_INITRD works and then rewrite the Gemini boot process
> to use it.  It seemed like we had two interpretations:
>
> 1. The BI_INITRD boot record contains the start address and the size
>    of the initrd.
>
> 2. The BI_INITRD boot record contains the entire initrd itself (as a
>    really large boot record).

I thought we had agreed on 1 (and nothing uses it yet anyhow).  Tho my
memory could be hazy.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

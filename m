Date: Thu, 7 Feb 2002 14:56:20 -0700
From: Val Henson <val@nmt.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
Message-ID: <20020207145620.E19569@boardwalk>
References: <20020207144308.C19569@boardwalk> <20020207215105.3897@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020207215105.3897@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Thu, Feb 07, 2002 at 10:51:05PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 07, 2002 at 10:51:05PM +0100, Benjamin Herrenschmidt wrote:
>
> >as a result.  Any ideas for stressing the system harder?
>
> Well, I don't know what your previous kernel had, but recent _devel
> has my fix to limit lowmem to what can be mapped by BATs on SMP.
> That may help with the 7410. If the machine ends up beeing really
> stable, then I'll have to look into CPU bugs for my 7450 problems.

The previous kernel was 2.4.12 based, with a hack from me to limit
lowmem to 512MB.  And I was using SCSI, which has hardware bugs on my
board, in addition to exercising bounce buffers much more strongly.
In summary, I don't have the faintest idea what was causing the
hangs.  I'll try booting my old 2.4.12 kernel NFS root and see if it's
just as stable.

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

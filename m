Message-ID: <39D35A6C.EF02CCC1@mvista.com>
Date: Thu, 28 Sep 2000 10:49:16 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: mgreer@mvista.com,
        LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Memory corruption bug in HardHat-1.2 CPU6 workaround
References: <20000928052449.15FE54FF6B@brixi.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> I've just noticed some potential memory corruption bugs associated with
> the CPU6 workaround in the PPC HardHat-1.2 kernel.

In what LSP of the 1.2 CDK?  Mark has been predominantly discussing
the 8240/755 Sandpoint and providing pointers to software that doesn't
represent integration of the 8xx software on the CDK.

Is this a problem in one of the MPC8xx LSPs of the CDK?

> ...meaning that they will clobber an unrelated value in memory 8 bytes
> after cpu6_bug.

I'm travelling and don't have an 8xx LSP handy, but there was supposed
to be sufficient space allocated here to prevent this condition.  Thanks
for the note and I will check the software to ensure this is correct in
the MPC8xx CDKs.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

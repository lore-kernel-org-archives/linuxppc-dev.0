Message-ID: <3827E054.90CFFA7B@jlc.net>
Date: Tue, 09 Nov 1999 03:50:28 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Peter Brown <pfb@syseng.anu.edu.au>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX860 mbxroot.min problem.
References: <38266602.C333E608@syseng.anu.edu.au> <3827AC9F.5F4BFE01@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
> 
> Peter Brown wrote:
> >
> > I'm attempting to boot an MBX860 card using the mbxroot.min.tgz filesystem.
> 
> Other than this is all pretty old, it looks like it should boot fine.


OK EVERYONE, you can stop sending individual messages to me.  My
eyes aren't working right at this hour of the morning for me....I see
it now.

I guess something is broken there, however that code has long been
deleted.  All 8xx kernels now boot using BOOTP to discover all of
this information.  The only solution is to use a newer kernel.

My apologies.....

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

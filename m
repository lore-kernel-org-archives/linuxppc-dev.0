From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15313.12899.480254.317750@cargo.ozlabs.ibm.com>
Date: Sat, 20 Oct 2001 18:14:27 +1000 (EST)
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: arch/ppc/kernel clutter
In-Reply-To: <Pine.LNX.4.33.0110191426580.27649-100000@opal.biophys.uni-duesseldorf.de>
References: <15312.6740.808012.183783@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.33.0110191426580.27649-100000@opal.biophys.uni-duesseldorf.de>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:

> I was wondering how you guys could live with that situation anyway. Why
> not have arch/ppc/powermac/, arch/ppc/prep/, arch/ppc/chrp/ and more of
> the same?

We had that at one stage and decided that it was better to have
powermac, prep and chrp in one directory.  Having a directory per
platform would give us a lot of directories each with only a couple of
files, which I don't want to see.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org, trini@kernel.crashing.org
Subject: Re: state of 4xx code in 2.5.x
References: <15743.64401.154459.318050@argo.ozlabs.ibm.com>
From: Roland Dreier <roland@topspin.com>
Date: 11 Sep 2002 19:48:27 -0700
In-Reply-To: <15743.64401.154459.318050@argo.ozlabs.ibm.com>
Message-ID: <52u1kvditg.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:

    Paul> I am becoming increasingly concerned about the quality, or
    Paul> lack of it, of the 4xx code generally.  I think we need
    Paul> someone who has a good amount of experience in Linux kernel
    Paul> coding to go through all the 4xx code and clean it up and
    Paul> simplify it where possible.  I know that the 4xx family have
    Paul> quirks (e.g. DCRs) which make it difficult in places to do
    Paul> things simply, but with a bit of creativity we can make the
    Paul> code clearer and simpler than it is at the moment.

Sounds great!  I don't have the time (or the kernel hacking cred,
probably) to do much more than cheer you on, unfortunately.  However I
would suggest that you start by proposing a design before you start
moving code around.  I definitely agree that there is far too much
duplicated and confusing code, but I don't think things will improve
without a clear articulation of what belongs where (ie what goes in
include/asm-ppc/, arch/ppc/platforms/, arch/ppc/kernel/ etc., and what
the difference is between 4xx.h, 405.h, 405gp.h)

Best,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

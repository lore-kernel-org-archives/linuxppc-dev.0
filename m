Message-ID: <19991208230549.2008.qmail@web302.mail.yahoo.com>
Date: Wed, 8 Dec 1999 15:05:49 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: PowerPC 4xx Port Progress
To: Grant Erickson <grant@lcse.umn.edu>, linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>   POSIX conformance testing by UNIFIX
> 
> Then it runs off into nowhere land which isn't too
> surprising considering
> that there are a lot of holes yet.

>   o Timer code is probably wrong, BogoMIPS seems
> low.

Grant,

I'm not familiar with the 4xx core, but I ran into
similar trouble with the 8xx CPUs.  I found that I
wasn't setting the ICTRL and DER registers.  The core
is serialized by default, which could explain the low
Bogomips rating (see the ICTRL reg).  If the DER is
set incorrectly, you may enter debug mode instead of
your exception vectors for various exceptions.  This
caused my target to crash.

Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

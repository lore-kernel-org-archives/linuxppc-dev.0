To: greyham@research.canon.com.au (Graham Stoney)
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Console on SMC2 (was: Re: MPC823 Serial ports)
References: <19991025013531.7E210705@elph.research.canon.com.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Oct 1999 14:47:10 +0200
In-Reply-To: greyham@research.canon.com.au's message of "Mon, 25 Oct 1999 11:35:31 +1000 (EST)"
Message-ID: <kfyu2nfr4j5.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


greyham@research.canon.com.au (Graham Stoney) writes:

> Hi Marcus,
> 
> Marcus Sundberg writes:
> > TTYAUX_MAJOR corresponds to the /dev/cua* devices, which are obsolete.
> 
> Could you please clarify what you mean here? Are you saying that the /dev/cua*
> devices are obsolete?

Yes, has been so since before 2.2.0 IIRC.

> If so, what's the replacement?

>From linux/Documentation/Changes:
     Also, please remember that cua* devices are now obsolete.  Switch to
  the corresponding ttyS* device instead (e.g., cua0 -> ttyS0, cua1 ->
  ttyS1, etc.).

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

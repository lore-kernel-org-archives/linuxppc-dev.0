Message-ID: <37FF406C.BF6C6BEF@jlc.net>
Date: Sat, 09 Oct 1999 09:17:32 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Jim Lewis <jlewis@mvista.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Strange behavior on FADS with ICTRL==0
References: <37FEA5CA.57808DB3@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Lewis wrote:


> ........ If the ISCT_SER field of the
> ICTRL register is set to 0 (which is the value on reset), the system is
> very unstable.

You have to be very careful with the configuration of 8xx control and
debug registers.  Depending upon the silicon revision, there are certain
errata that require explicit settings of these registers.  This is certainly
one of them.....some die require serialization to be set, others require you
never set it, others require subsequent software work around depending
upon the setting.


    -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

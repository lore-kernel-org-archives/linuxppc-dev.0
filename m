From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15745.23603.313915.127474@argo.ozlabs.ibm.com>
Date: Fri, 13 Sep 2002 13:32:03 +1000 (EST)
To: Segher Boessenkool <segher@koffie.nl>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
In-Reply-To: <3D80F2F7.3FB3AE4B@koffie.nl>
References: <3D80F2F7.3FB3AE4B@koffie.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Segher Boessenkool writes:

> I'm currently implementing a Linux driver to use the PowerPC
> performance monitor counters (PMC's).  I thought I'd ask here

Cool. :)

> For 1), the program-to-be-monitored just needs to be able to
> select a set of PMC's, and read the counters.  Pretty easy.

I'm curious - how are you going to cope with the fact that different
PPC implementations have different numbers of PMCs and different
sets of events (and numbering of the events) that the PMCs will count?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

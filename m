To: kd@flaga.is
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: zeroing of bss segments
References: <OFA20EA33C.C47E920B-ON002568C1.0056A7A4@flaga.is>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 14 Apr 2000 18:05:22 +0200
In-Reply-To: kd@flaga.is's message of "Fri, 14 Apr 2000 16:00:40 +0000"
Message-ID: <kfyaeiwr7lp.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is writes:

> It seems that many of the problems that I am seeing on our mpc823 board is
> related to uninitialized static variables in the glibc library. What lead
> my to this conclusion is that many of the programs are segfaulting and
> always in the glibc library.
> Tracking down the individual functions, such as gethostbyname and the
> sunrpc functions and explicitly setting static pointers to NULL in the
> library code cured many of the segfaults.

Are you sure you have patched your glibc correctly for 8xx?

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3DAB2923.3060607@mvista.com>
Date: Mon, 14 Oct 2002 15:29:23 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Matt Porter <porter@cox.net>,
	Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Binary Compatibility of various flavors of PPC
References: <816F7B3D-DFAF-11D6-A599-003065BFB10E@motorola.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> I'd have to agree with that.  Classic PPC core implementations currently
>> offer the broadest selection of userspace binary compatible processors.
>
>
> I agree, but it depends on how important floating point is to ones
> userspace.  If they do not care about FP then all of the PPC processors
> 4xx/8xx/82xx/7xx/74xx/e500 all provide a compatible integer instruction
> set.

But as Matt said (and later reminded me) the 405 has errata that is 405
specific, and the 8xx and 403 half smaller cacheline size.  So anything
statically linked may not operator correctly....  but yes, if you switch the
whole of userspace to soft-floating point then "in general" they should all be
compatable.

IMHO it is a bad practice to mix and match userspace between 403/8xx, 405, and
7xx/74xx/82xx series of processors.  It is just asking for problems..  but it
definatly can be done given proper resources and understanding of the underlying
problems.

--Mark

> - kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

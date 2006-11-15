Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 99F6267CB7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 03:49:21 +1100 (EST)
Message-ID: <455B3E84.8010606@mock.com>
Date: Wed, 15 Nov 2006 08:21:24 -0800
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: aldo lab <aldo.lab@gmail.com>
Subject: Re: Performance on PowerQuicc8280 linux based
References: <6e41d1460611150654j6e532ae1pbe378685539e257e@mail.gmail.com>
In-Reply-To: <6e41d1460611150654j6e532ae1pbe378685539e257e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm no big help, but the problem might be TLB related instead of cache
related.  The performance of embedded PPCs with small TLBs requiring
software assist for TLB misses can be performance sensitive to TLB misses.

jeff


aldo lab wrote:
> I've a system Linux based on ppc8280 platform with unstable
> performance from a compiling to another.
> I've a board with 2 Ethernet interfaces and I inject traffic in one of
> this and analyze the number of packets that I receive in the other
> one.
> I obtained 60000 pkt/s the first time, the second time i recompiling
> the kernel just changing some died function that is not involved in
> the flow of the packet.In that case I obtained 47000 pkt/s and it
> seems that moving code position change the behaviour in term of cache
> functionality.
> Could someone help me to understand this strange situation
> 
> Regards
> Aldo
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

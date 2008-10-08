Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACAAADE29A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 03:10:42 +1100 (EST)
Message-ID: <48ECD433.2080706@billgatliff.com>
Date: Wed, 08 Oct 2008 10:39:31 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Dominik Bozek <domino@mikroswiat.pl>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48ECC611.3030309@mikroswiat.pl>
In-Reply-To: <48ECC611.3030309@mikroswiat.pl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dominik Bozek wrote:
> Hi all,
> 
> I have done a test of memcpy() and __copy_tofrom_user() on the mpc8313.
> And the major conclusion is that __copy_tofrom_user is more efficient
> than memcpy. Sometimes about 40%.

Have you looked at the two implementations?  I'm not as well-versed on PPC as
ARM, but I know the latter's __copy_* functions are optimized to be almost
unintelligible.  If your benchmark memcpy() implementation isn't, then you
aren't comparing apples-to-apples.

40% improvement is within what I could imagine getting from a hand-crafted,
no-holds-barred memcpy() implementation.  I'd look more carefully at that code.


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com

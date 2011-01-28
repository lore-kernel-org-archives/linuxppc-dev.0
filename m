Return-Path: <schwab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 56754B70F9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 21:14:33 +1100 (EST)
From: Andreas Schwab <schwab@redhat.com>
To: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 2/7] PowerPC: add unlikely() to BUG_ON()
References: <4D41B213.4070606@caviumnetworks.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC2D__37237.0892241181$1296205746$gmane$org@saturn3.aculab.com>
Date: Fri, 28 Jan 2011 11:14:16 +0100
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC2D__37237.0892241181$1296205746$gmane$org@saturn3.aculab.com>
	(David Laight's message of "Fri, 28 Jan 2011 09:05:59 -0000")
Message-ID: <m31v3xxrlz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Coly Li <bosong.ly@taobao.com>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, Yong Zhang <yong.zhang0@gmail.com>,
	Wang Cong <xiyou.wangcong@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"David Laight" <David.Laight@ACULAB.COM> writes:

> Also, as (I think) in some of the generated code quoted,
> use of __builtin_expect() with a boolean expression can
> force some versions of gcc to generate the integer
> value of the expression

That's more likely a side effect of the definition of likely/unlikely:
they expand to !!(x).

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."

Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net (are.twiddle.net [75.149.56.221])
	by ozlabs.org (Postfix) with ESMTP id 73E5FDDFD5
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 02:17:20 +1000 (EST)
Message-ID: <49E4B70F.1030304@twiddle.net>
Date: Tue, 14 Apr 2009 09:17:19 -0700
From: Richard Henderson <rth@twiddle.net>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Fix bug in __futex_atomic_op
References: <18915.54309.632699.346771@cargo.ozlabs.ibm.com>
In-Reply-To: <18915.54309.632699.346771@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Can anyone see any reason why the FUTEX_OP_SET case can't just do a
> __put_user?

Because you need to return the old value.  Despite the name,
it's an exchange operation not a set.


r~

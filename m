Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17939.13376.772183.912217@cargo.ozlabs.ibm.com>
Date: Wed, 4 Apr 2007 15:14:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] Allow drivers to map individual 4k pages to userspace
In-Reply-To: <adamz1odbpr.fsf@cisco.com>
References: <17938.14674.621036.256587@cargo.ozlabs.ibm.com>
	<adar6r0dg0q.fsf@cisco.com>
	<1175657025.30879.45.camel@localhost.localdomain>
	<adamz1odbpr.fsf@cisco.com>
Cc: Joachim Fenkes <fenkes@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier writes:

> If I'm going off on something irrelevant, just tell me.  But is there
> a chance that you would want to build a kernel that can boot on both a
> platform that has eHCA, and also on some other platform that cannot
> support remap_4k_pfn?

In a word, no. :)

Only 64-bit machines have eHCA.  A 64-bit powerpc kernel only supports
64-bit machines, and all 64-bit powerpc machines can support
remap_4k_pfn.  I don't see any difficulty arising with future 64-bit
embedded processors either.

Paul.

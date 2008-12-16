Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 742FBDDF9D
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 16:12:48 +1100 (EST)
Date: Mon, 15 Dec 2008 23:12:35 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] [RFC] Pass a valid token to rats_call() in phyp-dump code.
Message-ID: <20081216051235.GS6958@localdomain>
References: <20081216043429.GC14890@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081216043429.GC14890@ozlabs.org>
Cc: Manish Ahuja <mahuja@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> ibm_configure_kernel_dump, is passed as the token to rtas_call() but I
> cannot see where it is initialised.  Set it to something sane?

Yes, please.

Acked-by: Nathan Lynch <ntl@pobox.com>

Would be good to know whether the dump area registration and dump
retrieval are working with your changes.  Doesn't look like they could
have worked at all with this bug.

Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-5.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A97ACDDE1F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 08:33:16 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: wli@movementarian.org
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
References: <20090203164930.GA10101@mtls03> <ada8wonnh3t.fsf@cisco.com>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
	<aday6wmn2vr.fsf@cisco.com>
	<20090203222601.747ca8b7.akpm@linux-foundation.org>
	<adad4dym2zp.fsf@cisco.com> <20090204210037.GC10229@movementarian.org>
Date: Wed, 04 Feb 2009 13:31:43 -0800
In-Reply-To: <20090204210037.GC10229@movementarian.org>
	(wli@movementarian.org's message of "Wed, 4 Feb 2009 16:00:37 -0500")
Message-ID: <adazlh1lwhs.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Eli Cohen <eli@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > You should be able to find the head of a compound page using the
 > compound_head() inline, so try

 > 	PAGE_SIZE << compound_order(compound_head(page))

Thanks!  Looks like that should be exactly what we need.

 - R.

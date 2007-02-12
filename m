Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FDF2DDD02
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:50:04 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1CNo0eW023126
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 18:50:00 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1CNo0ee551936
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 16:50:00 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1CNo07b017949
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 16:50:00 -0700
Date: Mon, 12 Feb 2007 17:49:59 -0600
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 0/4] spidernet: support for Celleb
Message-ID: <20070212234959.GF923@austin.ibm.com>
References: <200702070849.l178nvGC005341@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702070849.l178nvGC005341@toshiba.co.jp>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, jim@jklewis.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 07, 2007 at 05:49:50PM +0900, Ishizaki Kou wrote:
> This is a revised spidernet patch set based on
> netdev-2.6.git#upstream.

Tested this series of patches together with Jen's "version 3" patch,
it worked for me. Code looks reasonable.  Thus

Acked-by: Linas Vepstas <linas@austin.ibm.com>

I'm somewhat unclear as to whethr I should be doing 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

instead.

--linas

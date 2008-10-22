Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D9B56477FC
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 07:44:08 +1100 (EST)
In-Reply-To: <kexec-user-2@bga.com>
References: <kexec-user-2@bga.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <85f28cc33f5eb349962712e541762b38@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/2 kexec-tools] ppc64: segemments are sorted
Date: Wed, 22 Oct 2008 15:47:45 -0500
To: Milton Miller <miltonm@bga.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 22, 2008, at 3:39 PM, Milton Miller wrote:

> Every time add_segment is called, the segments are sorted.  If the 
> first
> hole in memory is not big enough for the kernel then something besides
> the kernel may be at

info->segment[0].

> ---
> Found during custom environment testing with several reserved blocks of
> memory, not the usual case.

milton

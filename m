Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 89EC9DE492
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:11:06 +1100 (EST)
Date: Thu, 25 Jan 2007 16:16:58 -0600
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] powerpc: MPIC: support more than 256 sources
Message-ID: <20070125221658.GA22587@lixom.net>
References: <20070125213834.GA22121@lixom.net>
	<4E97B8B2-51B5-4914-9203-534006D3F5BD@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E97B8B2-51B5-4914-9203-534006D3F5BD@watson.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 04:37:31PM -0500, Jimi Xenidis wrote:
> Why is this a flag and not just passed into mpic_alloc()?

I didn't want to make it automatic because the openpic specification says
you only have to support 8-bit vectors. So if there's an implementation
out there with 256 sources and only 8-bit vectors (and we put IPI/timers
above 256), things will break instead of the uppermost sources just not
being usable/valid.

If noone is worried about that, then I'm fine with doing it automatically
instead.

-Olof

Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id B1BE7DDE35
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 15:01:38 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2834283pyg.27
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 20:01:37 -0800 (PST)
Date: Wed, 20 Feb 2008 22:01:27 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2][POWERPC] Fix initial lmb add region with a non-zero
	base
Message-ID: <20080220220127.08555476@vader.jdub.homelinux.org>
In-Reply-To: <18364.57054.427433.405627@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
	<20080219.163003.152862383.davem@davemloft.net>
	<4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
	<18364.57054.427433.405627@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 21 Feb 2008 13:15:58 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Kumar Gala writes:
> 
> > np.  Are we trying to get this into 2.6.25 or .26?
> 
> I was going to put it into my powerpc-next branch and put it in
> 2.6.26.  I don't see any need for it to go in 2.6.25.

Is that a new branch you're going to create, or the normal "for-2.6.xx"?

josh

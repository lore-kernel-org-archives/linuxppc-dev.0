Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 04D09DDF2E
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 22:05:54 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so506548hsz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Oct 2008 05:05:53 -0700 (PDT)
Date: Fri, 3 Oct 2008 08:04:41 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix a typo that breaks canyonland support
Message-ID: <20081003120441.GB2229@yoda.jdub.homelinux.org>
References: <20081003093338.50543DDF78@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081003093338.50543DDF78@ozlabs.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 03, 2008 at 07:33:20PM +1000, Benjamin Herrenschmidt wrote:
>A typo in the new ppc4xx_simple.c prevents proper detection of
>the AMCC Canyonland board.
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This is already fixed in my 'next' branch.

josh

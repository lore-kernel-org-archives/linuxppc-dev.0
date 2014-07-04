Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCA891A000D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 17:50:44 +1000 (EST)
Date: Fri, 4 Jul 2014 17:46:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 1/3] powerpc/kvm: Remove redundant save of SIER AND MMCR2
Message-ID: <20140704074649.GA5852@iris.ozlabs.ibm.com>
References: <1404367956-19515-1-git-send-email-joel@jms.id.au>
 <1404367956-19515-2-git-send-email-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404367956-19515-2-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2014 at 03:42:34PM +0930, Joel Stanley wrote:
> These two registers are already saved in the block above. Aside from
> being unnecessary, by the time we get down to the second save location
> r8 no longer contains MMCR2, so we are clobbering the saved value with
> PMC5.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Eek!

Acked-by: Paul Mackerras <paulus@samba.org>

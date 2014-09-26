Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C9A51A0121
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 23:24:48 +1000 (EST)
Date: Fri, 26 Sep 2014 23:24:47 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 10/15] powerpc/mm: Add hooks for cxl
Message-ID: <20140926232447.30bdcddb@kryten>
In-Reply-To: <1411731209.1733.51.camel@ale.ozlabs.ibm.com>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-11-git-send-email-mikey@neuling.org>
 <20140926143309.33c0eeac@kryten>
 <1411731209.1733.51.camel@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Mikey,

> We only map what a user processes maps and we tear it down when the
> process is teared down (on the file descriptor release).  So I think
> we are ok.  
> 
> Unless there's some lazy teardown you're alluding to that I'm missing?

I was trying to make sure things like the TLB batching code won't allow
a tlbie to be postponed until after a CAPI mapping is destroyed. It's
been ages since I looked at that part of the mm code.

Anton

Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cjYc56q0zF1S4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 16:59:32 +1000 (AEST)
Message-ID: <1525417165.2560.11.camel@russell.cc>
Subject: Re: [PATCH 08/13] powerpc/eeh: Introduce eeh_for_each_pe()
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 May 2018 16:59:25 +1000
In-Reply-To: <8fd8b61f3e04aadd476116404b9047a898870f0b.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <8fd8b61f3e04aadd476116404b9047a898870f0b.1525242772.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-02 at 16:36 +1000, Sam Bobroff wrote:
> Add a for_each-style macro for iterating through PEs without the
> boilerplate required by a traversal function. eeh_pe_next() is now
> exported, as it is now used directly in place.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>

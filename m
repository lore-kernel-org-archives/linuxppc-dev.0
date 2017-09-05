Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmlT75dkzzDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 21:52:43 +1000 (AEST)
Subject: Re: powerpc/eeh: Delete an error message for a failed memory
 allocation in two functions
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <3xkKq44VX5z9t3x@ozlabs.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <84ad8bb6-2ecf-ef88-ddc1-0fb830170a20@users.sourceforge.net>
Date: Tue, 5 Sep 2017 13:52:17 +0200
MIME-Version: 1.0
In-Reply-To: <3xkKq44VX5z9t3x@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/6ab41161b44a3b4d504ac29c9dd997

Thanks that you picked another update suggestion up.

* It might matter to mention that only one patch hunk was accepted in this case.

* Can it be that the adjusted commit subject does contain a typo at the moment?
  Would the wording “powerpc/eeh: Delete a message for an "out of memory error"
  (at init time)” be more appropriate there?

Regards,
Markus

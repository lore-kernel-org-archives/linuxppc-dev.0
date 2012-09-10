Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EEAC32C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 15:19:34 +1000 (EST)
Message-ID: <1347254365.11820.1.camel@pasglop>
Subject: Re: [PATCH] powerpc-powernv: added tce_get callback for powernv
 platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 10 Sep 2012 15:19:25 +1000
In-Reply-To: <20120910023554.GP12554@truffula.fritz.box>
References: <1346807975-2323-1-git-send-email-aik@ozlabs.ru>
 <20120910023554.GP12554@truffula.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-10 at 12:35 +1000, David Gibson wrote:
> Looks good to me.  Ben, do you plan to merge this soon?

Yes, it will hit powerpc-next any minute now.

Cheers,
Ben.

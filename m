Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ABADBB6F92
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 15:43:31 +1100 (EST)
Message-ID: <1320986595.21206.49.camel@pasglop>
Subject: Re: [RFC PATCH 08/17] powerpc/e500: Remove conditional "lwsync"
 substitution
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Date: Fri, 11 Nov 2011 15:43:15 +1100
In-Reply-To: <4567A1A9-51D2-4D21-9080-BD3D78901C1D@boeing.com>
References: <4E42AB6F.1050900@freescale.com>
 <1320883635-17194-9-git-send-email-Kyle.D.Moffett@boeing.com>
 <3937191C-A735-4668-8E80-9FB4B35E2F63@kernel.crashing.org>
 <20111110163100.GA11983@schlenkerla.am.freescale.net>
 <AC287A9B-0C8B-494E-95CD-A33014AECE22@kernel.crashing.org>
 <20111110170334.GF11983@schlenkerla.am.freescale.net>
 <4567A1A9-51D2-4D21-9080-BD3D78901C1D@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-10 at 14:27 -0600, Moffett, Kyle D wrote:
> 
> Does this mean that PPC_BOOK3E_64 needs to be split into two separate
> Book 3-III families the same way that 32-bit has been split?  Is there
> another way around it? 

No, I don't want more split, on the contrary.

Cheers,
Ben.

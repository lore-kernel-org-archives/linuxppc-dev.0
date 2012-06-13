Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7CBC1B6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 10:40:47 +1000 (EST)
Message-ID: <1339548038.9220.80.camel@pasglop>
Subject: RE: [PATCH] powerpc/44x: Support OCM(On Chip Memory) for APM821xx
 SoC and Bluestone board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vinh Huu Tuong Nguyen <vhtnguyen@apm.com>
Date: Wed, 13 Jun 2012 10:40:38 +1000
In-Reply-To: <da2d8ae5f5008c4695d1898b9e121c1f@mail.gmail.com>
References: <1336362768-31326-1-git-send-email-vhtnguyen@apm.com>
 <da2d8ae5f5008c4695d1898b9e121c1f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-06-12 at 17:26 +0700, Vinh Huu Tuong Nguyen wrote:
> > -----Original Message-----
> > From: Vinh Nguyen Huu Tuong [mailto:vhtnguyen@apm.com]
> > Sent: Monday, May 07, 2012 10:53 AM
> > To: Benjamin Herrenschmidt; Paul Mackerras; Josh Boyer; Matt Porter;
> > Grant Likely; Rob Herring; Duc Dang; David S. Miller; Kumar Gala; Li
> > Yang; Ashish Kalra; Anatolij Gustschin; Liu Gang; linuxppc-
> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; devicetree-
> > discuss@lists.ozlabs.org
> > Cc: Vinh Nguyen Huu Tuong
> > Subject: [PATCH] powerpc/44x: Support OCM(On Chip Memory) for APM821xx
> > SoC and Bluestone board

Such a CC list won't get you any good will. Send it only to the relevant
mailing lists with possibly the -one- concerned maintainer on CC. I
doubt Dave Miller or Matt Porter give any damn about those patches.

As for why it wasn't reviewed yet, well, reviewers are a finite resource
with limited time dedicated to it. If the patch is properly formed and
was posted to the linuxppc-dev@ozlabs.org, it should be tracked on
patchwork.ozlabs.org and won't be lost. Double check it's there (if it's
not, then the patch was probably corrupt).

Cheers,
Ben.

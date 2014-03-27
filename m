Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4E66214008B
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 17:42:05 +1100 (EST)
Received: by mail-ob0-f175.google.com with SMTP id uy5so3758940obc.34
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2014 23:42:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395901724.5569.83.camel@pasglop>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohpom-mnOXpOUChasOMVTrRGknvZNA_bOcq6ZfGTRmUM5W9A@mail.gmail.com>
 <1395901724.5569.83.camel@pasglop>
Date: Thu, 27 Mar 2014 12:12:03 +0530
Message-ID: <CAKohpomt9UprOcKwXjtYcCeemOgi06KVVSWV1oeQ+OZOCEDiuA@mail.gmail.com>
Subject: Re: [PATCH v4] powernv: Dynamic Frequency Scaling Enablement
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27 March 2014 11:58, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Any other comment ? :-)

Just gave on the patch..

> Because it depends on some other stuff in -next, I think it's best if
> this gets merged via Rafael's tree, unless someone can point me at
> the necessary pre-requisites in the form of a topic branch I can
> pull in powerpc along with this.

If you don't have any issues, let it go through Rafael's tree.

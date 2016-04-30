Return-Path: <glikely@secretlab.ca>
Received: from mail-ig0-x244.google.com (mail-ig0-x244.google.com
 [IPv6:2607:f8b0:4001:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxnds67hczDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 20:59:59 +1000 (AEST)
Received: by mail-ig0-x244.google.com with SMTP id rc4so5287627igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 03:59:59 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <CACxGe6uY-b49YfgBEkJmhjrZ5Pv3+_GPGj+eZOWOkJ43Qc2e4A@mail.gmail.com>
References: <CACxGe6uY-b49YfgBEkJmhjrZ5Pv3+_GPGj+eZOWOkJ43Qc2e4A@mail.gmail.com>
From: Grant Likely <grant.likely@linaro.org>
Date: Sat, 30 Apr 2016 11:59:37 +0100
Message-ID: <CACxGe6vx4c7pYe7Z+joz1uWyZd2yzG68dc3Oyd4y9HXNBTqTLA@mail.gmail.com>
Subject: Fwd: Devicetree specification process
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm pleased to announce the first *very early draft* of the new
devicetree specification that I and several others have been working
on since January. This document picks up where ePAPR left off in 2012.
I'm announcing it now along with the new devicetree.org organization
which will handle governance for the spec.

We're still in the process of getting all the details sorted out (not
everything on the website is accurate at the moment), but in the mean
time you can look at the current state of the document. At the moment,
it is little more than repackaging the ePAPR text. The next step will
be pulling in the new core bindings that were never covered by ePAPR.
You can look at a draft copy of the document here:

https://github.com/kvekaria/devicetree-specification-released/blob/master/prerelease/DevicetreeSpecification-20160429-pre1.pdf

If you want to help out, the document source markup can be cloned from
GitHub. You can find the project page here:

https://github.com/devicetree-org/devicetree-specification

Feedback is greatly appreciate. Please send any comments and/or
changes to the devicetree specification mailing list:

devicetree-spec@vger.kernel.org

For more information, you can refer to the slides presented at BKK16 and ELC[1].

[1] http://elinux.org/images/b/b7/Devicetree_specification_linaro_connect_bangkok_2016.pdf

Thanks,
g.

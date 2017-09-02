Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xl9Zc22JgzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Sep 2017 08:22:00 +1000 (AEST)
Message-ID: <1504390854.4974.108.camel@kernel.crashing.org>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org, monstr@monstr.eu, Linux PPC Mailing List
 <linuxppc-dev@lists.ozlabs.org>
Date: Sun, 03 Sep 2017 08:20:54 +1000
In-Reply-To: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
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

On Sat, 2017-09-02 at 04:43 -0400, Robert P. J. Day wrote:
> Since, according to a recent devicetree ML posting by Rob Herring,
> the node "/chosen@0" is most likely for real Open Firmware and does
> not apply to DTSpec, remove all remaining tests and references for
> that node, of which there are very few left:

Technically that would break Open Firmware systems where the node is
really called chosen@0

Now I'm not sure such a thing actually exist however.

My collection of DTs don't seem to have one, except in the ancient html
variants that were extracted by the pengionppc folks for the original
PowerMac 8600 but I wonder if that's a bug in the extraction script
since they also have @0 on /packages etc...

Ben.

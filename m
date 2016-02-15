Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECB9F1A0336
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 21:38:06 +1100 (AEDT)
Message-ID: <1455532680.26205.8.camel@ellerman.id.au>
Subject: Rebase of my fixes branch
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 gwshan@linux.vnet.ibm.com
Date: Mon, 15 Feb 2016 21:38:00 +1100
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

Hi folks,

FYI I've rebased my fixes branch.

Unfortunately we had a couple of fixes in fixes that needed fixes in order to
be actual fixes.

So if you're basing some work on it you'll have to fetch and rebase.

The old head commit was: 0fe53e8d335bfc02f81300b70211e61fb931a725
           and now it's: c777e2a8b65420b31dac28a453e35be984f5808b

cheers

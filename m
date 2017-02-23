Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTrQH1YjZzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:43:03 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTrQF2Stxz9s7N
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:43:01 +1100 (AEDT)
Message-ID: <1487891222.23576.246.camel@kernel.crashing.org>
Subject: Re: [PATCH 01/12] drm/ast: Fix AST2400 POST failure without BMC FW
 or VBIOS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dri-devel@lists.freedesktop.org
Cc: linuxppc-dev@ozlabs.org, airlied@redhat.com, eich@suse.come
Date: Fri, 24 Feb 2017 10:07:02 +1100
In-Reply-To: <20170223225357.9572-1-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
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

Note: The whole series with the fixed cset comment for patch 11
can be also found there:

https://github.com/ozbenh/linux-ast/commits/master

Cheers,
Ben.

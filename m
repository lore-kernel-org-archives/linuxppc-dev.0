Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3NVq2n7mzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:29:23 +1000 (AEST)
Date: Thu, 13 Apr 2017 11:29:01 +1000
From: Anton Blanchard <anton@samba.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>,
 benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Avoid taking a data miss on every userspace
 instruction miss
Message-ID: <20170413112901.3fbaac05@kryten>
In-Reply-To: <1492046172.8380.16.camel@gmail.com>
References: <3vzNHv6zMZz9s9c@ozlabs.org> <1492046172.8380.16.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

> FYI: The version you applied does not have checks for is_write

Yeah, we decided to do that in a follow up patch. I'm ok if someone
gets to it before me :)

Anton

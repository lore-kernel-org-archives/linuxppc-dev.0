Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sj2mk5qybzDrPW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 09:07:18 +1000 (AEST)
Date: Mon, 26 Sep 2016 09:07:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Only disable
 HAVE_EFFICIENT_UNALIGNED_ACCESS on POWER7 little endian
Message-ID: <20160926090703.34f572ed@kryten>
In-Reply-To: <1474843503.2857.237.camel@kernel.crashing.org>
References: <1474806941-5006-1-git-send-email-anton@ozlabs.org>
 <1474843503.2857.237.camel@kernel.crashing.org>
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

Hi Ben,

> Hrm.. this should really be a runtime switch...

I wonder if anyone is still running POWER7 LE, perhaps we could drop it
entirely.

Anton

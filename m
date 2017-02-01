Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD0YB0MLRzDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 22:01:02 +1100 (AEDT)
Date: Wed, 1 Feb 2017 22:00:44 +1100
From: Anton Blanchard <anton@samba.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/perf: Add PM_INST_DISP event to Power9
 event list
Message-ID: <20170201220044.09df70f7@kryten>
In-Reply-To: <1485779021-31936-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1485779021-31936-2-git-send-email-maddy@linux.vnet.ibm.com>
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

Hi Maddy,

> +EVENT(PM_INST_DISP,				0x200f0)
> +EVENT(PM_INST_DISP_ALT,				0x300f0)

Are you sure these are the right events? 0x200f2, 0x300f2 should be
instruction dispatch I think.

Anton

Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyLgL0XQ0zDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 16:49:02 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b22so10783269pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 21:49:01 -0800 (PST)
Date: Tue, 10 Jan 2017 15:48:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 03/12] powerpc: Use soft_enabled_set api to update
 paca->soft_enabled
Message-ID: <20170110154848.14528fb6@roar.ozlabs.ibm.com>
In-Reply-To: <1483968978-16035-4-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483968978-16035-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1483968978-16035-4-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon,  9 Jan 2017 19:06:09 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Force use of soft_enabled_set() wrapper to update paca-soft_enabled
> wherever possisble. Also add a new wrapper function, soft_enabled_set_return(),
> added to force the paca->soft_enabled updates.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

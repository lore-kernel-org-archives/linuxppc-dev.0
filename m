Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwFJ45JyrzDqg7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 23:39:32 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y134so5504982pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 06:39:32 -0700 (PDT)
Date: Thu, 21 Jul 2016 23:39:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/14] powerpc: build-time fixup alternate feature
 relative addresses
Message-ID: <20160721233914.385f8b9d@roar.ozlabs.ibm.com>
In-Reply-To: <1469083453-9279-4-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
 <1469083453-9279-4-git-send-email-npiggin@gmail.com>
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

On Thu, 21 Jul 2016 16:44:02 +1000
Nicholas Piggin <nicholas.piggin@gmail.com> wrote:

> fixup_entry data could be stripped at build time after this change.

Actually that's crazy, no it couldn't! Fortunately I didn't attempt
to try that. Laziness pays off yet again.

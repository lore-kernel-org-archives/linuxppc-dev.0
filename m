Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXVvn63hJzDr62
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Nov 2017 15:45:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>, Gustavo Romero <gusbromero@gmail.com>
Subject: Re: [PATCH] powerpc/tm: Make the tm code more readable
In-Reply-To: <1508871539-26146-1-git-send-email-leitao@debian.org>
References: <1508871539-26146-1-git-send-email-leitao@debian.org>
Date: Thu, 09 Nov 2017 15:45:09 +1100
Message-ID: <87po8s12ne.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Breno Leitao <leitao@debian.org> writes:

> As discussed in the mailing list, renaming tm_disabled global variable
> since it has nothing to do with concept we have been using in
> tm_enable() and tm_enabled() functions. This will avoid a possible
> confusion that tm_enable() would change tm_disable variable.
>
> I am also taking the opportunity to change some comments that still
> reference old fields that were changed in commit 000ec280e3dd ("powerpc:
> tm: Rename transct_(*) to ck(\1)_state").

Please don't do two unrelated things in one patch. Just send separate
patches, I'm quite happy to take comment cleanup patches when they're
meaningful.

Also this no longer applies, since I merged Cyril's recent changes. Can
you please rebase on my merge or next branch.

cheers

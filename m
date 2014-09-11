Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C31951A0074
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 07:55:14 +1000 (EST)
Date: Fri, 12 Sep 2014 07:55:14 +1000
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/4] powerpc: Move htab_remove_mapping function
 prototype into header file
Message-ID: <20140912075514.06703989@kryten>
In-Reply-To: <20140823012940.303e3ebc@canb.auug.org.au>
References: <1408488921-19187-1-git-send-email-anton@samba.org>
 <1408488921-19187-4-git-send-email-anton@samba.org>
 <20140823012940.303e3ebc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Stephen,

> Please be consistent about "extern" use (unless this file is already
> inconsistent, I guess).  (I know that the current trend is to remove
> "extern" in header files - I just happen to disagree with that
> trend. :-))

Good idea, fixed this for the next rev.

Anton

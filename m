Return-Path: <geoff@infradead.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAC2C1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 08:53:52 +1000 (AEST)
Message-ID: <1443826397.12222.0.camel@infradead.org>
Subject: Re: [PATCH] powerpc/ps3: Remove unused os_area_db_id_video_mode
From: Geoff Levand <geoff@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Date: Fri, 02 Oct 2015 15:53:17 -0700
In-Reply-To: <1443147288-26392-1-git-send-email-mpe@ellerman.id.au>
References: <1443147288-26392-1-git-send-email-mpe@ellerman.id.au>
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

On Fri, 2015-09-25 at 12:14 +1000, Michael Ellerman wrote:
> This struct is unused, which is now a build error with gcc 6:
> 
>   error: 'os_area_db_id_video_mode' defined but not used
> 
> There doesn't seem to be any good reason to keep it around so remove it,
> it's in the history if anyone needs it.

Looks OK.

Acked-by: Geoff Levand <geoff@infradead.org>

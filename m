Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptd65jb9zF0bq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:06 +1000 (AEST)
In-Reply-To: <20180622192749.24954-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: =?utf-8?q?powerpc/mm=3A_remove_warning_about_=E2=80=98type?=
 =?utf-8?q?=E2=80=99_being_set?=
Message-Id: <41ptd634t0z9sBD@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-06-22 at 19:27:47 UTC, Mathieu Malaterre wrote:
> ‘type’ is only used when CONFIG_DEBUG_HIGHMEM is set. So add a possibly
> unused tag to variable. Remove warning treated as error with W=1:
> 
>   arch/powerpc/mm/highmem.c:59:6: error: variable ‘type’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fce278af81daf8599f9e94883cbe43

cheers

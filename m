Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AE681A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 16:42:42 +1000 (AEST)
Date: Fri, 10 Jul 2015 16:42:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dinar valeev <k0da@opensuse.org>
Cc: linuxppc-dev@ozlabs.org, aik@ozlabs.ru, nikunj@linux.vnet.ibm.com,
 thuth@redhat.com, Dinar Valeev <dvaleev@suse.com>
Subject: Re: [PATCH v2] Caps in not always shift
Message-ID: <20150710064238.GB19196@iris.ozlabs.ibm.com>
References: <1436374064-4116-1-git-send-email-k0da@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436374064-4116-1-git-send-email-k0da@opensuse.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 08, 2015 at 06:47:44PM +0200, Dinar valeev wrote:
> From: Dinar Valeev <dvaleev@suse.com>
> 
> Caps behaves like shift only for latin characters.
> In case we're typing - for example with caps enabled, SLOF picks _ char
> from shifted table.
> 
> Threat caps as shift only for letters.

"Treat" not "Threat".

And I suggest you make the subject "Caps is ..." rather than
"Caps in ...".

Paul.

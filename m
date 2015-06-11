Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0909F1A09FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 01:38:38 +1000 (AEST)
Date: Thu, 11 Jun 2015 08:38:35 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Cristian Stoica <cristian.stoica@freescale.com>
Cc: horia.geanta@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: support sizes greater than an unsigned long
Message-ID: <20150611153835.GB5058@kroah.com>
References: <1431620684-20123-1-git-send-email-cristian.stoica@freescale.com>
 <1431683064-29584-1-git-send-email-cristian.stoica@freescale.com>
 <55799E38.1000004@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55799E38.1000004@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2015 at 05:42:00PM +0300, Cristian Stoica wrote:
> Hi Greg,
> 
> Can you have a look at this patch?
> 
> https://patchwork.kernel.org/patch/6413191/

Why?

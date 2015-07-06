Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C86541A0452
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 17:22:34 +1000 (AEST)
Date: Mon, 6 Jul 2015 09:22:24 +0200
From: Thomas Huth <thuth@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Nikunj A Dadhania
 <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH slof] README: Update with patch submittion note
Message-ID: <20150706092224.414d7e5e@thh440s>
In-Reply-To: <1436155750-16815-1-git-send-email-aik@ozlabs.ru>
References: <1436155750-16815-1-git-send-email-aik@ozlabs.ru>
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

On Mon,  6 Jul 2015 14:09:10 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This adds a maillist and emails to be used when posting a patch for SLOF.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> I was asked to describe somewhere how to post new patches so this is the first
> attempt. Please fix my english and add/remove personal emails and any other
> comments are also welcome. Thanks!

I think you should add least add a sentence that the subject should
contain "[SLOF PATCH...]", so that people on the list can see at a
first glance that the patch is about SLOF.

And IMHO it would be really better to finally have a dedicated mailing
list for SLOF - even if it's low traffic only. It would help filtering
your mails and maybe also attract people who do not want to receive the
whole other traffic from the linux-ppc mailing list.

 Thomas

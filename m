Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C66931A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 18:44:21 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D07214076D
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2015 18:44:21 +1000 (AEST)
Date: Mon, 29 Jun 2015 10:44:12 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, segher@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF v2 3/5] disk-label: rename confusing "block" word
Message-ID: <20150629104412.426a60dc@thh440s>
In-Reply-To: <1435214729-15952-4-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1435214729-15952-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1435214729-15952-4-git-send-email-nikunj@linux.vnet.ibm.com>
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

On Thu, 25 Jun 2015 12:15:27 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> "block" word is not a block number, actually its an allocated host
> address.  Rename it to disk-buf along with a associated
> size(disk-buf-size=4096) for using during allocation/free.
> 
> Also renaming the helper routine read-sector to read-disk-buf. This
> routine assumes the address to be disk-buf and only takes sector number
> as argument.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/packages/disk-label.fs | 78 ++++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 37 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

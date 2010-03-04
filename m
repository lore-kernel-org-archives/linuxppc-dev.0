Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id F1711B7CD5
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 13:45:59 +1100 (EST)
Date: Thu, 4 Mar 2010 08:14:27 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100304024427.GB31594@amit-x200.redhat.com>
References: <1267630188-30824-1-git-send-email-amit.shah@redhat.com>
	<20100303155522.6d6a4562@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100303155522.6d6a4562@lxorguk.ukuu.org.uk>
Cc: linuxppc-dev@ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Wed) Mar 03 2010 [15:55:22], Alan Cox wrote:
> On Wed,  3 Mar 2010 20:59:48 +0530
> Amit Shah <amit.shah@redhat.com> wrote:
> 
> > Alan pointed out a race in the code where hvc_remove is invoked. The
> > recent virtio_console work is the first user of hvc_remove().
> 
> Looks better to me.

Thanks, Alan.

Ben, can you pick this up via your tree if it looks good to you?

		Amit

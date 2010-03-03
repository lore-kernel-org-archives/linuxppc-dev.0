Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83A19B7CE8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 02:52:06 +1100 (EST)
Date: Wed, 3 Mar 2010 15:55:22 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100303155522.6d6a4562@lxorguk.ukuu.org.uk>
In-Reply-To: <1267630188-30824-1-git-send-email-amit.shah@redhat.com>
References: <1267630188-30824-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed,  3 Mar 2010 20:59:48 +0530
Amit Shah <amit.shah@redhat.com> wrote:

> Alan pointed out a race in the code where hvc_remove is invoked. The
> recent virtio_console work is the first user of hvc_remove().

Looks better to me.

Alan

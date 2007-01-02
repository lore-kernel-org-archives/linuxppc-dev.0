Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 57238DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:57:03 +1100 (EST)
Date: Tue, 2 Jan 2007 16:55:52 -0600
From: Olof Johansson <olof@lixom.net>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] fix unbalanced uses of of_node_put
Message-ID: <20070102165552.054ccd1f@localhost.localdomain>
In-Reply-To: <20070102223706.GB6279@localdomain>
References: <20070102223706.GB6279@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2 Jan 2007 16:37:06 -0600 Nathan Lynch <ntl@pobox.com> wrote:

> The (maple|pasemi)_init_IRQ functions call of_node_put(root) once more
> than they should, causing the refcount of the root node to underflow,
> which triggers the WARN_ON in kref_get.
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>

Acked-by: Olof Johansson <olof@lixom.net>


Thanks for fixing this, Nathan.

Thanks,

Olof

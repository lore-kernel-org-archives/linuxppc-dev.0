Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWwHR4psyzDqYv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 00:44:50 +1000 (AEST)
Subject: Re: [PATCH 05/11] serial: uuc_uart: constify uart_ops structures
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502605310-4314-6-git-send-email-Julia.Lawall@lip6.fr>
From: Timur Tabi <timur@tabi.org>
Message-ID: <b5eaeaab-6c8b-b4d1-5667-a879cdda4019@tabi.org>
Date: Tue, 15 Aug 2017 09:44:39 -0500
MIME-Version: 1.0
In-Reply-To: <1502605310-4314-6-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/13/17 1:21 AM, Julia Lawall wrote:
> These uart_ops structures are only stored in the ops field of a
> uart_port structure and this fields is const, so the uart_ops
> structures can also be const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall<Julia.Lawall@lip6.fr>

Acked-by: Timur Tabi <timur@tabi.org>

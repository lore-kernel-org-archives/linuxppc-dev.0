Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysY5G06pFzDrcV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 09:22:23 +1100 (AEDT)
Subject: Re: [PATCH 0/3] tty/serial/ucc_uart: Adjustments for two functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
From: Timur Tabi <timur@tabi.org>
Message-ID: <cf5c7c5d-ceee-58bd-1dfb-8f9dff48abe3@tabi.org>
Date: Wed, 6 Dec 2017 16:22:18 -0600
MIME-Version: 1.0
In-Reply-To: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/2017 03:10 PM, SF Markus Elfring wrote:
> 
> Three update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (3):
>    Delete an error message for a failed memory allocation in ucc_uart_probe()
>    Improve a size determination in ucc_uart_probe()
>    Fix a typo in a comment line

All three:

Acked-by: Timur Tabi <timur@tabi.org>

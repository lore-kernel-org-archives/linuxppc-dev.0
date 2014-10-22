Return-Path: <ralf@linux-mips.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by lists.ozlabs.org (Postfix) with ESMTP id 08A871A0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Oct 2014 02:44:53 +1100 (AEDT)
Received: from localhost.localdomain ([127.0.0.1]:38887 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S27012153AbaJVPbuZjnWa (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Wed, 22 Oct 2014 17:31:50 +0200
Date: Wed, 22 Oct 2014 17:31:36 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 08/47] kernel: Move pm_power_off to common code
Message-ID: <20141022153136.GA11045@linux-mips.org>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-9-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413864783-3271-9-git-send-email-linux@roeck-us.net>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux@openrisc.net,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net,
 linux-pm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 20, 2014 at 09:12:24PM -0700, Guenter Roeck wrote:

> pm_power_off is defined for all architectures. Move it to common code.
> 
> Have all architectures call do_kernel_power_off instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_power_off from machine_power_off instead.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Hirokazu Takata <takata@linux-m32r.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Richard Weinberger <richard@nod.at>
> Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

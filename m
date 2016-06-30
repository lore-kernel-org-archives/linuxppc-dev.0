Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgJvF3j0tzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:36:41 +1000 (AEST)
In-Reply-To: <1467171519-19882-3-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: robh@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, sjitindarsingh@gmail.com
Subject: Re: [V5,
 3/3] powerpc/drivers: Add driver for operator panel on FSP machines
Message-Id: <3rgJvF1P6tz9syq@ozlabs.org>
Date: Thu, 30 Jun 2016 22:36:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 03:38:39 UTC, Suraj Jitindar Singh wrote:
> Implement new character device driver to allow access from user space
> to the operator panel display present on IBM Power Systems machines
> with FSPs.
> 
> This will allow status information to be presented on the display which
> is visible to a user.
> 
> The driver implements a character buffer which a user can read/write
> by accessing the device (/dev/op_panel). This buffer is then displayed on
> the operator panel display. Any attempt to write past the last character
> position will have no effect and attempts to write more characters than
> the size of the display will be truncated. The device may only be accessed
> by a single process at a time.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43a1dd9b5fc64184e578ac1570

cheers

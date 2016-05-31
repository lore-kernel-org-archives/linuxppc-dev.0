Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJpz94BtYzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:05:57 +1000 (AEST)
Date: Tue, 31 May 2016 20:05:19 +1000
From: Anton Blanchard <anton@samba.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: inline current_stack_pointer()
Message-ID: <20160531200519.25fdf12c@kryten>
In-Reply-To: <20160523084602.53F771A239A@localhost.localdomain>
References: <20160523084602.53F771A239A@localhost.localdomain>
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

Hi,

> current_stack_pointeur() is a single instruction function. it
> It is not worth breaking the execution flow with a bl/blr for a
> single instruction

Check out bfe9a2cfe91a ("powerpc: Reimplement __get_SP() as a function
not a define") to see why we made it a function.

Anton

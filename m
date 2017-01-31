Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCBlX2gVczDq74
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 14:37:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Kujau <lists@nerdbynature.de>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC] powerpc/32: fix handling of stack protector with
 recent GCC
In-Reply-To: <alpine.DEB.2.20.999.1701301611590.3270@trent.utfs.org>
References: <20170116090031.4843668B50@localhost.localdomain>
 <alpine.DEB.2.20.999.1701301611590.3270@trent.utfs.org>
Date: Tue, 31 Jan 2017 14:37:11 +1100
Message-ID: <87lgtrvr14.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Kujau <lists@nerdbynature.de> writes:

> On Mon, 16 Jan 2017, Christophe Leroy wrote:
>> Since 2005, powerpc GCC doesn't manage anymore __stack_chk_guard as
>> a global variable but as some value located at -0x7008(r2)
>
> Is this still an "RFC" or is there a chance that this will land in 4.10?

No. I've reverted the stack protector support in my fixes branch (which
is in linux-next), and it will go into 4.10 this week.

cheers

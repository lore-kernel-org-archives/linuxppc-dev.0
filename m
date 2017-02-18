Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQG0k2cYjzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 14:41:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: implement clear_bit_unlock_is_negative_byte()
In-Reply-To: <20170103185828.31311-1-npiggin@gmail.com>
References: <20170103185828.31311-1-npiggin@gmail.com>
Date: Sat, 18 Feb 2017 14:41:57 +1100
Message-ID: <87lgt4i2re.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Commit b91e1302ad9b8 ("mm: optimize PageWaiters bit use for
> unlock_page()") added a special bitop function to speed up
> unlock_page(). Implement this for powerpc.

I know you wrote this to work on 32 and 64-bit, but I don't have a good
way to test it on 32-bit at the moment as my 32-bit box is blowing
chunks.

So I've taken this but made it 64-bit only for now.

cheers

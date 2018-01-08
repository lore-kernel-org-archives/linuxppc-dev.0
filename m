Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFLb41VphzF0RD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 14:38:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: christophe leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Time to get rid of CPU6 ERRATA on powerpc/8xx ?
In-Reply-To: <26b73379-141c-a705-a552-6ee2b94f4961@c-s.fr>
References: <26b73379-141c-a705-a552-6ee2b94f4961@c-s.fr>
Date: Mon, 08 Jan 2018 14:38:23 +1100
Message-ID: <871sj12f68.fsf@concordia.ellerman.id.au>
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

christophe leroy <christophe.leroy@c-s.fr> writes:

> Today, Linux kernel includes a workaround for CPU6 ERRATA on the 8xx 
> powerpc.
>
> This ERRATA exists on the 801, the 823, the 855/860 before revision C.0
> It doesn't concern any modern versions of the 8xx, neither the 860 past 
> and including rev C.0, nor the 866 nor the 885
>
> This workaround complicates the TLBmiss and TLBerror handlers and make 
> the code more and more unreadable.
>
> Since this workaround addresses very old versions of the 8xx, I'd like 
> to get rid of it. Do you see any good reason to keep it today ? If not I 
> will come with a cleanup patch in the coming weeks.

I'm happy for you to remove it, and if someone notices and complains
loudly we can always put it back.

cheers

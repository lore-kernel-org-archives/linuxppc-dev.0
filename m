Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwjYN6rw7zDrMG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 17:52:40 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g202so6887073pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 00:52:40 -0700 (PDT)
Date: Fri, 22 Jul 2016 17:52:30 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 05/14] powerpc/pseries: 4GB exception handler offsets
Message-ID: <20160722175230.012e3d6f@roar.ozlabs.ibm.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F50086C@AcuExch.aculab.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
 <1469083453-9279-6-git-send-email-npiggin@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F50086C@AcuExch.aculab.com>
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

On Thu, 21 Jul 2016 14:34:10 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Nicholas Piggin
> > Sent: 21 July 2016 07:44  
> ...
> > @@ -739,7 +739,8 @@ kvmppc_skip_Hinterrupt:
> >   * Ensure that any handlers that get invoked from the exception
> > prologs
> >   * above are below the first 64KB (0x10000) of the kernel image
> > because
> >   * the prologs assemble the addresses of these handlers using the
> > - * LOAD_HANDLER macro, which uses an ori instruction.
> > + * LOAD_HANDLER_4G macro, which uses an ori instruction. Care must
> > also
> > + * be taken because relative branches can only address 32K in each
> > direction. */  
> 
> That comment now looks wrong.

You're right, I'll correct it.

Thanks,
Nick

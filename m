Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXW9l0SHSzDsGT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 11:55:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common.
In-Reply-To: <20160911120743.GA22669@simonLocalRHEL7.x64>
References: <1471695863-8660-1-git-send-email-wei.guo.simon@gmail.com>
 <878tvmrjoc.fsf@possimpible.ozlabs.ibm.com>
 <20160824073826.GA16442@simonLocalRHEL7.x64>
 <871t1dr716.fsf@possimpible.ozlabs.ibm.com>
 <871t0tl4zf.fsf@concordia.ellerman.id.au>
 <20160911120743.GA22669@simonLocalRHEL7.x64>
Date: Mon, 12 Sep 2016 11:55:54 +1000
Message-ID: <87a8fdridx.fsf@concordia.ellerman.id.au>
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

Simon Guo <wei.guo.simon@gmail.com> writes:
> Thanks for the feedback regarding too many ifdefs.  Is following implemention 
> better for this issue?

Yes that looks much better. Can you send a proper patch with a change
log and so on, thanks.

cheers

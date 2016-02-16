Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1BEA1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 13:45:49 +1100 (AEDT)
Message-ID: <1455590749.14533.0.camel@ellerman.id.au>
Subject: Re: Rebase of my fixes branch
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com
Date: Tue, 16 Feb 2016 13:45:49 +1100
In-Reply-To: <87a8n2fclk.fsf@linux.vnet.ibm.com>
References: <1455532680.26205.8.camel@ellerman.id.au>
 <87a8n2fclk.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-15 at 16:46 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
> > Hi folks,
> >
> > FYI I've rebased my fixes branch.
> >
> > Unfortunately we had a couple of fixes in fixes that needed fixes in order to
> > be actual fixes.
> >
> > So if you're basing some work on it you'll have to fetch and rebase.
> >
> > The old head commit was: 0fe53e8d335bfc02f81300b70211e61fb931a725
> >            and now it's: c777e2a8b65420b31dac28a453e35be984f5808b
> >
>
> Did we miss this ?
>
> http://mid.gmane.org/20160131083738.AA047140C40@ozlabs.org

No, it's still there in the non-rebased portion:

  https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=19f97c98307115f5a6b0bbf84850c9c272ce5dd3

cheers

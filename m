Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxjwf5jn6zDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:13:54 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id d5so4341957pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 04:13:54 -0700 (PDT)
Message-ID: <1498561981.7935.11.camel@gmail.com>
Subject: Re: [PATCH v4 3/9] powerpc/kprobes/optprobes: Move over to
 patch_instruction
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org,  mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org
Date: Tue, 27 Jun 2017 21:13:01 +1000
In-Reply-To: <83a385d1-872d-8782-7557-7fbc9352c54c@c-s.fr>
References: <20170627074903.19324-1-bsingharora@gmail.com>
 <20170627074903.19324-4-bsingharora@gmail.com>
 <83a385d1-872d-8782-7557-7fbc9352c54c@c-s.fr>
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

On Tue, 2017-06-27 at 10:34 +0200, Christophe LEROY wrote:
> 
> Le 27/06/2017 à 09:48, Balbir Singh a écrit :
> > With text moving to read-only migrate optprobes to using
> > the patch_instruction infrastructure. Without this optprobes
> > will fail and complain.
> > 
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> 
> Didn't Michael picked it up already ?
>

Yes, he did, I posted the entire series and I'll let him keep the
better versions, he has edited. I spoke to him, but I was not 100%
sure what was picked up, the email responses mentioned 3, but I thought
4 patches were picked up

Balbir Singh.

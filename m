Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwdgh5lzRzF1GF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 00:59:43 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 17so8745983pfw.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 05:59:43 -0800 (PST)
Date: Tue, 6 Mar 2018 23:59:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/10] powerpc/mm/slice: pass pointers to struct
 slice_mask where possible
Message-ID: <20180306235927.34ef5f44@roar.ozlabs.ibm.com>
In-Reply-To: <c0f290dd-33dd-6ba7-631a-1389b9a6d779@c-s.fr>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-5-npiggin@gmail.com>
 <c0f290dd-33dd-6ba7-631a-1389b9a6d779@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Mar 2018 14:43:40 +0100
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :

> > @@ -147,7 +149,8 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
> >   			__set_bit(i, ret->high_slices);
> >   }
> >   
> > -static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_mask *ret,
> > +static void slice_mask_for_size(struct mm_struct *mm, int psize,
> > +				struct slice_mask *ret,  
> 
> That seems to be cleanup only, is it worth including that in this patch ?

Yeah that can go.

Thanks,
Nick

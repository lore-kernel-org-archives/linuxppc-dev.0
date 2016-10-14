Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swPVd4c27zDt3V
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 21:49:29 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id hh10so5987087pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 03:49:29 -0700 (PDT)
Subject: Re: [PATCH v2] powerpc/64: option to force run-at-load to test
 relocation
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161014073133.24548-1-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <6a7af43c-64c8-60c4-bd73-29941d9474b8@gmail.com>
Date: Fri, 14 Oct 2016 21:49:31 +1100
MIME-Version: 1.0
In-Reply-To: <20161014073133.24548-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 14/10/16 18:31, Nicholas Piggin wrote:
> This adds a config option that can help exercise the case when
> the kernel is not running at PAGE_OFFSET.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

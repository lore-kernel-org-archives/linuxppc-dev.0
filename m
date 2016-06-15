Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x234.google.com (mail-yw0-x234.google.com
 [IPv6:2607:f8b0:4002:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV50D5fwpzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:09:00 +1000 (AEST)
Received: by mail-yw0-x234.google.com with SMTP id v137so17836668ywa.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 05:09:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k2hqaegk.fsf@skywalker.in.ibm.com>
References: <900d62c2-8bdf-839a-49fa-99aff00a4d87@gmail.com>
 <87k2hqaegk.fsf@skywalker.in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 15 Jun 2016 22:08:55 +1000
Message-ID: <CAKTCnzmLQoBLTyE+bDqwbCTJ+zDLih1Xzm17Qf3M=8v2MBAptQ@mail.gmail.com>
Subject: Re: [PATCH] Add support for power9 in ibm_architecture_vec
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2016 at 9:17 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> Shouldn't this be 125 + 16 ?

Actually the previous patch broke it and Ben fixed it, it should have
been 133 after adding POWER8NVL. My patch adds 16+1 (1 for the
OV1_PPC_3_00)

133+17 = 150

Michael, can you please check. I did a quick check with  gdb

Balbir Singh

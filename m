Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYL001wXQzDvxS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 12:05:35 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB715MXp053701
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 20:05:33 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2764ggbnpc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 20:05:33 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 7 Dec 2016 11:05:30 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2B1BC3578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 12:05:28 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB715SVX32571540
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 12:05:28 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB715RBm024495
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 12:05:27 +1100
Subject: Re: [kernel-hardening] Re: [PATCH 3/3] powerpc: enable support for
 GCC plugins
To: kernel-hardening@lists.openwall.com
References: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
 <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
 <CAGXu5jKQf4ReBkGC85+r_j1rVUFTZoeWk9A_mjhjnFHq1PAr8Q@mail.gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, PaX Team
 <pageexec@freemail.hu>,
 Brad Spengler <spender@grsecurity.net>, Michal Marek <mmarek@suse.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 7 Dec 2016 12:05:26 +1100
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKQf4ReBkGC85+r_j1rVUFTZoeWk9A_mjhjnFHq1PAr8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bf236e17-4b0f-e0c4-ba4d-4aadc1662b82@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/16 07:40, Kees Cook wrote:
>> Compile tested with all plugins enabled on gcc 4.6-6.2,
>> x86->ppc{32,64,64le} and 4.8-6.2 ppc64le->ppc{32,64,64le}. Thanks to
>> Chris Smart for help with this.
>
> I assume also tested on 5.2? :)

Tested on the latest subrevision of every release branch up till 6.2, so 
yes :)

>> I think it's best to take this through powerpc#next with an ACK from
>> Kees/Emese?
>
> That would be fine by me. Please consider the whole series:
>
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

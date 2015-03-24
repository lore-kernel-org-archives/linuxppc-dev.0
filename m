Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x22f.google.com (mail-ig0-x22f.google.com
 [IPv6:2607:f8b0:4001:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D4781A0332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 07:23:35 +1100 (AEDT)
Received: by igbqf9 with SMTP id qf9so8069171igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 13:23:30 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20150324153306.GG4701@suse.de>
References: <1427113443-20973-1-git-send-email-mgorman@suse.de>
 <20150324115141.GS28621@dastard> <20150324153306.GG4701@suse.de>
Date: Tue, 24 Mar 2015 13:23:30 -0700
Message-ID: <CA+55aFzPCbfMKPEpxntCvEK_SqjbBTppyZMW7W2C+ppnA4W4fw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Reduce system overhead of automatic NUMA balancing
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2015 at 8:33 AM, Mel Gorman <mgorman@suse.de> wrote:
> On Tue, Mar 24, 2015 at 10:51:41PM +1100, Dave Chinner wrote:
>>
>> So it looks like the patch set fixes the remaining regression and in
>> 2 of the four cases actually improves performance....
>
> \o/

W00t.

> Linus, these three patches plus the small fixlet for pmd_mkyoung (to match
> pte_mkyoung) is already in Andrew's tree. I'm expecting it'll arrive to
> you before 4.0 assuming nothing else goes pear shaped.

Yup. Thanks Mel,

                          Linus

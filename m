Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x22d.google.com (mail-yw0-x22d.google.com
 [IPv6:2607:f8b0:4002:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz23d0nbvzDr4r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 00:24:29 +1000 (AEST)
Received: by mail-yw0-x22d.google.com with SMTP id j11so37539076ywa.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 07:24:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Jun 2017 10:24:25 -0400
From: Tejun Heo <tj@kernel.org>
To: Eryu Guan <eguan@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1
 regression] mount ext4 fs results in kernel crash on PPC64le host)
Message-ID: <20170629142425.GB3531@htj.duckdns.org>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
 <20170629034122.GI23360@eguan.usersys.redhat.com>
 <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
 <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
 <878tkb9ewo.fsf@concordia.ellerman.id.au>
 <20170629135919.GU23360@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629135919.GU23360@eguan.usersys.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Could be the same problem as the one reported in the following thread.

 http://lkml.kernel.org/r/1497266622.15415.39.camel@abdul.in.ibm.com

The root cause there is ppc arch code not setting up possible cpu <->
numa mapping during boot.

Thanks.

-- 
tejun

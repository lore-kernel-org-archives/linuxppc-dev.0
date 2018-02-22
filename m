Return-Path: <keescook@google.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znLwb3YbbzF1cC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 04:30:38 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id e25so3806116uan.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 09:30:38 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180222130738.GG30681@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
 <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
 <87d1192nzc.fsf@concordia.ellerman.id.au>
 <20180213103213.GP3443@dhcp22.suse.cz>
 <CAGXu5jJZROQMxzxu+Dp3mVMktSg-oTB6pqk7fUyM_6_2oa9c_A@mail.gmail.com>
 <20180214092045.GZ3443@dhcp22.suse.cz>
 <CAGXu5jJCN_Js9rvM4RMjxDCDd4tVzWDo-jdnFiZs1D9e3cunrw@mail.gmail.com>
 <20180222130738.GG30681@dhcp22.suse.cz>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 22 Feb 2018 09:30:35 -0800
Message-ID: <CAGXu5jLLDOqoSn9usuA-pRLb5X=zK6MYdUVMPEh7x7oMgnU5cQ@mail.gmail.com>
Subject: Re: samples/seccomp/ broken when cross compiling s390,
 ppc allyesconfig
To: Michal Hocko <mhocko@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Drewry <wad@chromium.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 22, 2018 at 5:07 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 14-02-18 09:14:47, Kees Cook wrote:
> [...]
>> I can send it through my seccomp tree via James Morris.
>
> Could you please do it?

Hi! Yes, sorry, this fell through the cracks. Now applied.

-Kees

-- 
Kees Cook
Pixel Security

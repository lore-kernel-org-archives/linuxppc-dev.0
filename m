Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRTT86mcLzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 11:23:08 +1100 (AEDT)
Received: by mail-ua0-x244.google.com with SMTP id s41so499707uab.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 17:23:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171031183959.GA4313@lst.de>
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
 <20171031153004.GA31864@lst.de>
 <20171031162316.zerlu7ijb3qem33v@naverao1-tp.localdomain>
 <20171031183959.GA4313@lst.de>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 1 Nov 2017 11:23:05 +1100
Message-ID: <CAKTCnz=EaGbdCHCDGmsFSJujW+Rq5K=sVJw7USnoWhSJRVMjEA@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
To: Torsten Duwe <duwe@lst.de>
Cc: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 1, 2017 at 5:39 AM, Torsten Duwe <duwe@lst.de> wrote:
> On Tue, Oct 31, 2017 at 09:53:16PM +0530, Naveen N . Rao wrote:
>> On 2017/10/31 03:30PM, Torsten Duwe wrote:
>> >
>> > Maybe I failed to express my views properly; I find the whole approach
> [...]
>> > NAK'd-by: Torsten Duwe <duwe@suse.de>
>>
>> Hmm... that wasn't evident at all given Balbir's reponse to your
>> previous concerns and your lack of response for the same:
>> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg125350.html
>
> To me it was obvious that the root cause was kpatch's current inability to
> deal with ppc calling conventions when copying binary functions. Hence my
> hint at the discussion about a possible source-level solution that would
> work nicely for all architectures.

Alternatives are good,  at this point kpatch is important and should
be supported.
Source level alternatives are not controlled by us, but by distros and
tooling. I don't
think the NAK helps, it only states that kpatch should not be enabled
for ppc64 as
it needs a new stub. I know SuSE does not use kpatch, but we would want to be
able to support tools across distros.

When we get a source level patch tool going, I'd love to have it and have use it
by default and we can revisit the usefulness of this stub at that
point and deprecate
if required.

Balbir Singh.

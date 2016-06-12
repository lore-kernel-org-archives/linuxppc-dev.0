Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSPpT3hrFzDqYn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 04:39:45 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c74so8960587pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 11:39:45 -0700 (PDT)
Subject: Re: case sensitivity for devicetree node names
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <575B1D84.2010703@gmail.com> <575C68A1.1020701@gmail.com>
 <1465682743.19533.18.camel@kernel.crashing.org>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely
 <grant.likely@secretlab.ca>, David Gibson <david@gibson.dropbear.id.au>,
 "devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <575DAC69.5010804@gmail.com>
Date: Sun, 12 Jun 2016 11:39:37 -0700
MIME-Version: 1.0
In-Reply-To: <1465682743.19533.18.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/16 15:05, Benjamin Herrenschmidt wrote:
> On Sat, 2016-06-11 at 12:38 -0700, Frank Rowand wrote:
>> I chased through the history and found a 2.6.0-test5 announcement
>> which noted the patch from you which adds:
>>
>>   of_find_node_by_path()
>>   of_find_node_by_name()
>>   of_find_node_by_type()
>>   of_find_compatible_node()
>>
>> (And the patch is commit 394edd852a14 in the git recreation
>> of bitkeeper days, which is found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git)
>>
>> That version of the functions uses a case insensitive compare for
>> devicetree node names.
>>
>> Do you remember why you chose to not use a case sensitive compare?
> 
>>From memory, there were inconsistency in case on various earlier
> machines (notably old macs). I think that's the main reason.
> 
> Cheers,
> Ben.

Is there a kernel config option (or a small set of config options)
that would identify the affected machines?  It would be ok if
the option(s) also included some non-affected machines.  That
way we could use the case insensitive compare for a small
set of machines.

Return-Path: <glikely@secretlab.ca>
Received: from mail-ia0-x22a.google.com (mail-ia0-x22a.google.com
 [IPv6:2607:f8b0:4001:c02::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1EE62C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 08:00:45 +1000 (EST)
Received: by mail-ia0-f170.google.com with SMTP id 21so1735373iay.29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 15:00:42 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <CAOZdJXVnppPczrJi8jcNWLvabHFWP++Ex1QiEadbyLfApCR85g@mail.gmail.com>
References: <1365564999-24427-1-git-send-email-Yuantian.Tang@freescale.com>
 <D07C73A334FF604B95B3CBD2A545D07B0B144FD3@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130417145719.F194E3E2B73@localhost>
 <CAOZdJXVnppPczrJi8jcNWLvabHFWP++Ex1QiEadbyLfApCR85g@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Apr 2013 23:00:22 +0100
Message-ID: <CACxGe6usVnOdcxELXWcqtuW-YVvDJmyyW+Ds8UQ1xpoCY+_WAg@mail.gmail.com>
Subject: Re: [PATCH v2] of/base: release the node correctly in
 of_parse_phandle_with_args()
To: Timur Tabi <timur@tabi.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tang Yuantian-B29983 <B29983@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 17, 2013 at 10:52 PM, Timur Tabi <timur@tabi.org> wrote:
> On Wed, Apr 17, 2013 at 9:57 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>>> I really preciate if you can spend some times to review this patch.
>>
>> Applied, thanks.
>
> Pff.  Why do I bother?

Relax Timur:

http://git.secretlab.ca/?p=linux.git;a=commitdiff;h=b855f16b05a697ac1863adabe99bfba56e6d3199

g.



--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

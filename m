Return-Path: <jwboyer@gmail.com>
Received: from mail-oa0-x234.google.com (mail-oa0-x234.google.com
 [IPv6:2607:f8b0:4003:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F0D31A00E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 22:14:19 +1000 (EST)
Received: by mail-oa0-f52.google.com with SMTP id m19so8285610oag.25
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Sep 2014 05:14:16 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <1409903718.11359.30.camel@ale.ozlabs.ibm.com>
References: <1409894927.11359.26.camel@ale.ozlabs.ibm.com>
 <20140905071344.GA16024@visitor2.iram.es>
 <1409903718.11359.30.camel@ale.ozlabs.ibm.com>
Date: Fri, 5 Sep 2014 08:14:16 -0400
Message-ID: <CA+5PVA4beW2Ttuyy-gNFG-+JQm9w9-nDQGSiYxmecW=sL1b26A@mail.gmail.com>
Subject: Re: [PATCH v2] deb-pkg: Add support for powerpc little endian
From: Josh Boyer <jwboyer@fedoraproject.org>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Marek <mmarek@suse.cz>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 Ben Hutchings <ben@decadent.org.uk>,
 linux-kernel <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>,
 Leann Ogasawara <leann.ogasawara@canonical.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 5, 2014 at 3:55 AM, Michael Neuling <mikey@neuling.org> wrote:
> On Fri, 2014-09-05 at 09:13 +0200, Gabriel Paubert wrote:
>> On Fri, Sep 05, 2014 at 03:28:47PM +1000, Michael Neuling wrote:
>> > The Debian powerpc little endian architecture is called ppc64le.  This
>>
>> Huh? ppc64le or ppc64el?
>
> ppc64el.  Commit message is wrong.  Fixed below.

Yay!  Just like every other architecture, we continue to have the deb
based distros call it one thing, and the RPM based distros call it
another.  At least we're consistent in our inconsistency.

josh

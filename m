Return-Path: <joel.stan@gmail.com>
Received: from mail-qg0-x22d.google.com (mail-qg0-x22d.google.com
 [IPv6:2607:f8b0:400d:c04::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6B2D1A0033
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 01:25:00 +1000 (AEST)
Received: by qgej70 with SMTP id j70so26328297qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 08:24:58 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20150430151818.GA30542@redhat.com>
References: <CACPK8XeQjdmwFScvEDMo4ie7=-e6WfW0cvW=NMLqC+zpOOJeTg@mail.gmail.com>
 <20150430151818.GA30542@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 1 May 2015 01:24:37 +1000
Message-ID: <CACPK8XdrD_qUZ3ZGdOt+fhR=xbZFwCjeSnzHsT1MBAzw17OUjQ@mail.gmail.com>
Subject: Re: ppc64le crash in dm on 4.1+
To: Mike Snitzer <snitzer@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dm-devel@redhat.com, linuxppc-dev@lists.ozlabs.org, daxtens@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 1, 2015 at 1:18 AM, Mike Snitzer <snitzer@redhat.com> wrote:
>> I just booted 3d99e3fe13d473ac4578c37f477a59b829530764 (linus' tree as
>> of this morning) on a Tuletta and got the following:
>
> This is fixed with the following commit (which I just sent to Linus for
> 4.1-rc2 inclusion):
> https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=for-next&id=aa6df8dd28c01d9a3d2cfcfe9dd0a4a334d1cd81

Thanks!

Cheers,

Joel

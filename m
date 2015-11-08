Return-Path: <roy.qing.li@gmail.com>
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com
 [IPv6:2607:f8b0:400d:c04::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 614791A0142
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2015 13:49:16 +1100 (AEDT)
Received: by qgea14 with SMTP id a14so37718428qge.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2015 18:49:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOJe8K1O1ymO1Tpq6ygEMVB7ppnO8dAOb_+uhftB1_yHf-Y=Kg@mail.gmail.com>
References: <CAJFZqHzHQ1oH3uNeVQqLPXcff62FUeDdiz+DD2MN43xE=Qowvw@mail.gmail.com>
 <CAOJe8K1O1ymO1Tpq6ygEMVB7ppnO8dAOb_+uhftB1_yHf-Y=Kg@mail.gmail.com>
Date: Sun, 8 Nov 2015 10:49:12 +0800
Message-ID: <CAJFZqHzu05MKkmKckD02v92FREO3tvi_ycc=WqKkLecg2NmgyQ@mail.gmail.com>
Subject: Re: DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
From: Li RongQing <roy.qing.li@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 7, 2015 at 9:01 PM, Denis Kirjanov <kda@linux-powerpc.org> wrot=
e:
>> Does Anyone see this calltrace?  I see it from 3.19 to 4.3, did not
>> test it on other older release.
>
> http://www.gossamer-threads.com/lists/linux/kernel/2297694


I see this calltrace on 3.19, so it should not related to patch=E2=80=9C
[PATCH V3 0/3] perf/powerpc:Add ability to sample intr machine state
in powerpc=E2=80=9D

-R

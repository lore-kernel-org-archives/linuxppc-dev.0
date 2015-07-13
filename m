Return-Path: <dinarv@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E2C61A02BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2015 20:12:17 +1000 (AEST)
Received: from mail-wg0-x22d.google.com (mail-wg0-x22d.google.com
 [IPv6:2a00:1450:400c:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F1F6140773
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 20:12:15 +1000 (AEST)
Received: by wgkl9 with SMTP id l9so21861301wgk.1
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 03:12:12 -0700 (PDT)
MIME-Version: 1.0
Sender: dinarv@gmail.com
In-Reply-To: <20150710064238.GB19196@iris.ozlabs.ibm.com>
References: <1436374064-4116-1-git-send-email-k0da@opensuse.org>
 <20150710064238.GB19196@iris.ozlabs.ibm.com>
From: Dinar Valeev <k0da@opensuse.org>
Date: Mon, 13 Jul 2015 12:11:52 +0200
Message-ID: <CADqALGRObQKov6Qi9K-9t-VBbabzr3=d1k9TGEUEZ1LW5ZDtpw@mail.gmail.com>
Subject: Re: [PATCH v2] Caps in not always shift
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, aik@ozlabs.ru,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Dinar Valeev <dvaleev@suse.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 10, 2015 at 8:42 AM, Paul Mackerras <paulus@samba.org> wrote:
> On Wed, Jul 08, 2015 at 06:47:44PM +0200, Dinar valeev wrote:
>> From: Dinar Valeev <dvaleev@suse.com>
>>
>> Caps behaves like shift only for latin characters.
>> In case we're typing - for example with caps enabled, SLOF picks _ char
>> from shifted table.
>>
>> Threat caps as shift only for letters.
>
> "Treat" not "Threat".
>
> And I suggest you make the subject "Caps is ..." rather than
> "Caps in ...".
>
> Paul.
Thanks, I've sent v3

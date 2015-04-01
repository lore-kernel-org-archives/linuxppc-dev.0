Return-Path: <joel.stan@gmail.com>
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com
 [IPv6:2607:f8b0:400d:c04::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A3701A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 16:33:03 +1100 (AEDT)
Received: by qgf60 with SMTP id 60so34067678qgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 22:33:00 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <551B7978.8040502@linux.vnet.ibm.com>
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
 <551B7978.8040502@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Apr 2015 16:02:39 +1030
Message-ID: <CACPK8Xe-jkVK6vjNYE4LhGqB0jZV=LzGMESB9cOHU5oK+FZxCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel/reboot.c: Add orderly_reboot for graceful
 reboot
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 fabf@skynet.be, Jeremy Kerr <jk@ozlabs.org>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 1, 2015 at 3:22 PM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
>> +static int __orderly_poweroff(bool force)
>> +{
>> +     int ret;
>> +
>> +     ret = run_cmd(reboot_cmd);
>
> Would it be poweroff_cmd instead of reboot_cmd ? Dont see poweroff_cmd getting used.

Yes, good catch. Thanks.

Joel

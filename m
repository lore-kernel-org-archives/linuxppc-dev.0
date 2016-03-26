Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXBDG2S95zDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 18:11:26 +1100 (AEDT)
Received: from mail-qk0-x22b.google.com (mail-qk0-x22b.google.com
 [IPv6:2607:f8b0:400d:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qXBDF3XpLz9s4x
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Mar 2016 18:11:24 +1100 (AEDT)
Received: by mail-qk0-x22b.google.com with SMTP id o6so51596621qkc.2
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Mar 2016 00:11:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160324163734.GA7493@linux.vnet.ibm.com>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <20160324163734.GA7493@linux.vnet.ibm.com>
Date: Sat, 26 Mar 2016 18:11:22 +1100
Message-ID: <CAKTCnz=8giVb4_mdrPj0V1XvAnzpxLXZ9-XuJwB+R2NM16ZdzA@mail.gmail.com>
Subject: Re: [PATCH HACK 1/6] livepatch-test: Add more cases
From: Balbir Singh <bsingharora@gmail.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Torsten Duwe <duwe@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 25, 2016 at 3:37 AM, Kamalesh Babulal
<kamalesh@linux.vnet.ibm.com> wrote:
> * Michael Ellerman <mpe@ellerman.id.au> [2016-03-24 22:04:00]:
>
>> Not for merging.
>>
>
> Hi Michael,
>
> Loading the livepatch sample module, trigger following warning
>

The #if IS_MODULE(CONFIG_SCSI) code is buggy, you probably have
CONFIG_SCSI=y, make it M or you can fix the code yourself. I had the
same issue while testing

BTW, the tests worked fine with the changes proposed by Michael.

Balbir Singh

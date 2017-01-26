Return-Path: <hramrach@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8cRG68SMzDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 09:44:10 +1100 (AEDT)
Received: by mail-vk0-x244.google.com with SMTP id t8so20185960vke.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 14:44:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170126220536.GB31937@obsidianresearch.com>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <20170126220536.GB31937@obsidianresearch.com>
From: Michal Suchanek <hramrach@gmail.com>
Date: Thu, 26 Jan 2017 23:43:27 +0100
Message-ID: <CAOMqctQGoa_A9pCppWaDoudmvfgfVe3Vpg+OmUneF4vJ_8xqkg@mail.gmail.com>
Subject: Re: ibmvtpm byteswapping inconsistency
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: "Michal Such??nek" <msuchanek@suse.de>,
 Nayna Jain <nayna@linux.vnet.ibm.com>,
 Ashley Lai <ashleydlai@gmail.com>, Marcel Selhorst <tpmdd@selhorst.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 tpmdd-devel@lists.sourceforge.net,
 Paul Mackerras <paulus@samba.org>, Peter Huewe <peterhuewe@gmx.de>,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26 January 2017 at 23:05, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Jan 26, 2017 at 09:22:48PM +0100, Michal Such??nek wrote:
>
>> This is repeated a few times in the driver so I added memset to quiet
>> gcc and make behavior deterministic in case the unused fields get some
>> meaning in the future.
>
> Yep, reserved certainly needs to be zeroed.. Can you send a patch?

And len and data as well..

> memset is overkill...

Does not look so.

Michal

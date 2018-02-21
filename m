Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x235.google.com (mail-ua0-x235.google.com
 [IPv6:2607:f8b0:400c:c08::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmcF85PP0zF0nT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 23:27:23 +1100 (AEDT)
Received: by mail-ua0-x235.google.com with SMTP id m43so885430uah.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 04:27:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 21 Feb 2018 23:27:20 +1100
Message-ID: <CAKTCnzm8TJBWG2VG9Bts2zQF01Tsya72bJJSTRimE32XuFC-YA@mail.gmail.com>
Subject: Re: [RFC PATCH v0 0/2] ibm,dynamic-memory-v2 fix
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2018 at 9:36 PM, Bharata B Rao
<bharata@linux.vnet.ibm.com> wrote:
> Patch 1 fixes a bug that results in unexpected flag bit in
> ibm,dynamic-memory-v2 DT property and wrong number of entries
> getting created in the same property during hotplug.
>

Could you please elaborate on what this means? Is there a test case -
how do we reproduce this?

Balbir Singh.

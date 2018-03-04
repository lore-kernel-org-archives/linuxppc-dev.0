Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvbjm1fNYzDrvS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 08:27:55 +1100 (AEDT)
Received: by mail-vk0-x244.google.com with SMTP id s1so8639194vke.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 13:27:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180304173132.19677-1-vaibhav@linux.vnet.ibm.com>
References: <20180304173132.19677-1-vaibhav@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 5 Mar 2018 08:27:52 +1100
Message-ID: <CAKTCnznOU=8W2up5PQFRQHbmCZvht_8Vmt5F_gb1yaZEKQDTWw@mail.gmail.com>
Subject: Re: [PATCH] xmon: Clear all breakpoints when xmon is disabled via
 debugfs
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 5, 2018 at 4:31 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> wrote:
> Presently when xmon is disabled by debugfs any existing
> instruction/data-access breakpoints set are not disabled. This may
> lead to kernel oops when those breakpoints are hit as the necessary
> debugger hooks aren't installed.
>
> Hence this patch introduces a new function named clear_all_bpt()
> which is called when xmon is disabled via debugfs. The function will
> unpatch/clear all the trap and ciabr/dab based breakpoints.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir

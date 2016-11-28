Return-Path: <rjwysocki@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS7385XfvzDt0R
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:35:16 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id m203so18979686wma.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 05:35:16 -0800 (PST)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20161122050806.29564-1-andrew.donnellan@au1.ibm.com>
References: <20161122050806.29564-1-andrew.donnellan@au1.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Nov 2016 14:35:13 +0100
Message-ID: <CAJZ5v0gaKtYq__2BQDHFqR1s77kDuRdCY70PEYpczLsMdMtttQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle/powernv: staticise powernv_idle_driver
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 22, 2016 at 6:08 AM, Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
> powernv_idle_driver isn't exported, it can be made static. Found by sparse.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied.

Thanks,
Rafael

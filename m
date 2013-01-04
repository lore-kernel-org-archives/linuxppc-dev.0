Return-Path: <sshtylyov@mvista.com>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E488C2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 23:13:51 +1100 (EST)
Received: by mail-la0-f42.google.com with SMTP id fe20so9644972lab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2013 04:13:46 -0800 (PST)
Message-ID: <50E6C776.7060707@mvista.com>
Date: Fri, 04 Jan 2013 16:13:42 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line
 of /proc/stat" (commit 7386cdbf2f57ea8cff3c9fde93f206e58b9fe13f).
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
In-Reply-To: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, mhocko@suse.cz,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Mike Frysinger <vapier@gentoo.org>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 srivatsa.bhat@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 04-01-2013 6:58, Srivatsa Vaddagiri wrote:

> With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
> don't need the check for cpu_online() introduced in commit 7386cdbf. Offline

    Please also specify the summary of that commit in parens (or however you 
like).

> cpu's idle time as last recorded in its ts->idle_sleeptime will be reported
> (thus excluding its offline time as part of idle time statistics).

> Cc: mhocko@suse.cz
> Cc: srivatsa.bhat@linux.vnet.ibm.com
> Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>

WBR, Sergei

Return-Path: <vatsa@codeaurora.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine02.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF1892C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2013 06:29:39 +1100 (EST)
Date: Fri, 4 Jan 2013 11:29:34 -0800
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line
 of /proc/stat" (commit 7386cdbf2f57ea8cff3c9fde93f206e58b9fe13f).
Message-ID: <20130104192934.GB29866@quicinc.com>
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
 <50E6C776.7060707@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50E6C776.7060707@mvista.com>
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
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Sergei Shtylyov <sshtylyov@mvista.com> [2013-01-04 16:13:42]:

> >With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
> >don't need the check for cpu_online() introduced in commit 7386cdbf. Offline
> 
>    Please also specify the summary of that commit in parens (or
> however you like).

I had that in Subject line, but yes would be good to include in commit message
as well. I will incorporate that change alongwith anything else required in
next version of this patch.

- vatsa

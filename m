Return-Path: <tony.luck@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 485062C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 08:59:53 +1100 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Mark Salter <msalter@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/10] Kconfig: cleanup SERIO_I8042 dependencies
Date: Wed, 18 Dec 2013 21:59:49 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31D8CDD5@ORSMSX106.amr.corp.intel.com>
References: <1387295333-24684-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1387295333-24684-1-git-send-email-msalter@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This is v2 of the patch series. Changes from version 1:
>
>  o Added acks. arm, ia64, and sh are only ones without acks.

ia64 bits look OK

Acked-by: Tony Luck <tony.luck@intel.com>

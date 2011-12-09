Return-Path: <ralf@linux-mips.org>
Received: from linux-mips.org
 (f.f.9.9.2.4.2.4.4.f.3.3.9.d.c.f.0.0.0.0.a.e.3.0.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:3ea:0:fcd9:33f4:4242:99ff])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BC4EDB6F71
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 03:59:11 +1100 (EST)
Date: Fri, 9 Dec 2011 16:07:22 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Cong Wang <amwang@redhat.com>
Subject: Re: [PATCH 61/62] highmem: kill all __kmap_atomic()
Message-ID: <20111209160722.GB30988@linux-mips.org>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
 <1322371662-26166-62-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322371662-26166-62-git-send-email-amwang@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 David Howells <dhowells@redhat.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 James Bottomley <James.Bottomley@suse.de>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, linux-am33-list@redhat.com,
 Russell King <linux@arm.linux.org.uk>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kyle McMartin <kyle@mcmartin.ca>, Tejun Heo <tj@kernel.org>,
 akpm@linux-foundation.org, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 27, 2011 at 01:27:41PM +0800, Cong Wang wrote:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

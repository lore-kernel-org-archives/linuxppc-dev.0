Return-Path: <will.deacon@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id D15E82C023F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 01:54:36 +1100 (EST)
Date: Tue, 25 Feb 2014 14:53:47 +0000
From: Will Deacon <will.deacon@arm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 1/1] audit: Add CONFIG_HAVE_ARCH_AUDITSYSCALL
Message-ID: <20140225145347.GA23136@mudshark.cambridge.arm.com>
References: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "rgb@redhat.com" <rgb@redhat.com>, Catalin Marinas <Catalin.Marinas@arm.com>,
 "x86@kernel.org" <x86@kernel.org>, "arndb@arndb.de" <arndb@arndb.de>,
 "eparis@redhat.com" <eparis@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "dsaxena@linaro.org" <dsaxena@linaro.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "user-mode-linux-user@lists.sourceforge.net"
 <user-mode-linux-user@lists.sourceforge.net>,
 "linux-audit@redhat.com" <linux-audit@redhat.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 25, 2014 at 09:16:24AM +0000, AKASHI Takahiro wrote:
> Currently AUDITSYSCALL has a long list of architecture depencency:
>        depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML ||
> 		SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ALPHA)
> The purpose of this patch is to replace it with HAVE_ARCH_AUDITSYSCALL
> for simplicity.

Looks sensible to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

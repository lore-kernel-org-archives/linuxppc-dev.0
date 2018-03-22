Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406f7J6jghzF211
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:54:52 +1100 (AEDT)
Date: Thu, 22 Mar 2018 13:54:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
 fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
 jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
 davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
 gregkh@linuxfoundation.org, deepa.kernel@gmail.com, mhocko@suse.com,
 hughd@google.com, kstewart@linuxfoundation.org, pombredanne@nexb.com,
 steve.capper@arm.com, punit.agrawal@arm.com, paul.burton@mips.com,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com, keescook@chromium.org,
 bhsharma@redhat.com, riel@redhat.com, nitin.m.gupta@oracle.com,
 kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, jack@suse.cz,
 ross.zwisler@linux.intel.com, jglisse@redhat.com, willy@infradead.org,
 aarcange@redhat.com, oleg@redhat.com, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 2/2] Architecture defined limit on memory region
 random shift.
Message-Id: <20180322135448.046ada120ecd1ab3dd8f94aa@linux-foundation.org>
In-Reply-To: <1521736598-12812-3-git-send-email-blackzert@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <1521736598-12812-3-git-send-email-blackzert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Please add changelogs.  An explanation of what a "limit on memory
region random shift" is would be nice ;) Why does it exist, why are we
doing this, etc.  Surely there's something to be said - at present this
is just a lump of random code?

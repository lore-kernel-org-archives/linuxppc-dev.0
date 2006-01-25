Return-Path: <kenneth.w.chen@intel.com>
Received: from scsfmr002.sc.intel.com (fmr22.intel.com [143.183.121.14])
	by ozlabs.org (Postfix) with ESMTP id E1F5F68A8A
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 07:03:19 +1100 (EST)
Message-Id: <200601252002.k0PK2Mg31276@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Geert Uytterhoeven'" <geert@linux-m68k.org>
Subject: RE: [PATCH 5/6] fix warning on test_ti_thread_flag()
Date: Wed, 25 Jan 2006 12:02:21 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.62.0601251814350.19174@pademelon.sonytel.be>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, ultralinux@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	sparclinux@vger.kernel.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote on Wednesday, January 25, 2006 9:19 AM
> > I don't think you need to change the flags size.
> 
> Passing a pointer to a 32-bit entity to a function that takes a
> pointer to a 64-bit entity is a classical endianness bug. So it's
> better to change it, before people copy the code to a big endian
> platform.

Well, x86-64 and linux-ia64 both use little endian.  I don't
understand why you are barking at us with big endian issue.

- Ken


Side-note: cc list trimmed.

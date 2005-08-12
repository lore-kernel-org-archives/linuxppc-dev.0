Return-Path: <anton@ozlabs.org>
Date: Fri, 12 Aug 2005 15:06:09 +1000
From: Anton Blanchard <anton@samba.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Message-ID: <20050812050609.GA7355@krispykreme>
References: <a22149f6d9cc6f65ae2f8f339d982dd2@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a22149f6d9cc6f65ae2f8f339d982dd2@us.ibm.com>
Cc: PPC64-dev List <linuxppc64-dev@ozlabs.org>,
	Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: GDB backtrace and signal trampolines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> Would it make sense to limit the test to within a few hundred bytes of 
> the stack pointer? Or some better way to detect that the PC is in a 
> signal trampoline?

With recent kernels we should be able to use the dwarf2 unwind
information in the vdso I think.

Anton

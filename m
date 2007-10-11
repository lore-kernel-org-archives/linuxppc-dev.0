Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18190.41037.770255.259749@cargo.ozlabs.ibm.com>
Date: Fri, 12 Oct 2007 08:14:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 1/2] Replace NT_PRXFPREG with ELF_CORE_XFPREG_TYPE #define
In-Reply-To: <2C31F1C3-3337-483B-A463-767459305F1E@kernel.crashing.org>
References: <20071011071558.676463639@au1.ibm.com>
	<20071011072208.075979098@au1.ibm.com>
	<DFC6881D-E917-4EC5-B19C-8CE04E040B06@kernel.crashing.org>
	<18190.39864.4562.852292@cargo.ozlabs.ibm.com>
	<2C31F1C3-3337-483B-A463-767459305F1E@kernel.crashing.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> > ELF_CORE_XFPREG_TYPE is a suitable name for something that's used in
> > conjunction with a function called elf_core_copy_task_xfpregs().
> 
> agreed, I think the function name should change as well.

Maybe.  Let's do one step at a time...

Paul.

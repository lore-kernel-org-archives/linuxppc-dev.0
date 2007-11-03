Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18220.24362.604297.53633@cargo.ozlabs.ibm.com>
Date: Sat, 3 Nov 2007 22:44:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Balbir Singh" <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] Restore deterministic CPU accounting on powerpc
In-Reply-To: <661de9470711030202x24d0186cuc96a70156ecfa23f@mail.gmail.com>
References: <18218.44089.274628.680088@cargo.ozlabs.ibm.com>
	<661de9470711030202x24d0186cuc96a70156ecfa23f@mail.gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Balbir Singh writes:

> So, scaled accounting will not be available if
> CONFIG_VIRT_CPU_ACCOUNTING is defined? Am I reading this correctly

No, what makes you think that?  If VIRT_CPU_ACCOUNTING=y it is the
responsibility of the arch's account_process_tick to update the scaled
stats.  And the powerpc version does that by calling
account_user_time_scaled().

Paul.

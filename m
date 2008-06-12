Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18512.57420.267003.723681@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jun 2008 18:37:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH REPOST] IB/ehca: In case of lost interrupts,
	trigger EOI to reenable interrupts
In-Reply-To: <adaabht5klx.fsf@cisco.com>
References: <200806101644.34693.ossrosch@linux.vnet.ibm.com>
	<adatzg15ol2.fsf@cisco.com>
	<200806101701.47090.ossrosch@linux.vnet.ibm.com>
	<adaabht5klx.fsf@cisco.com>
Cc: TKLEIN@de.ibm.com, Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	THEMANN@de.ibm.com, fenkes@de.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier writes:

>  > > So just to be clear: this is a workaround for a hardware/firmware bug?
> 
>  > Yes it is.
> 
> OK, so paulus et al... does it seem like a good approach to call H_EOI
> from driver code (given that this driver makes tons of other hcalls)?

If this workaround is approved by the relevant hardware & firmware
folks, and demonstrably fixes the bug, then I am happy with it.

Paul.

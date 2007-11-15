Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18236.55874.204068.358524@cargo.ozlabs.ibm.com>
Date: Fri, 16 Nov 2007 10:46:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc1 on PPC64: machine check exception
In-Reply-To: <473C7B16.3050700@linux.vnet.ibm.com>
References: <472F1F4C.3010507@linux.vnet.ibm.com>
	<20071105154055.GA4746@kryten>
	<472F5C5E.4030607@linux.vnet.ibm.com>
	<473C7B16.3050700@linux.vnet.ibm.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vaidyanathan Srinivasan writes:

> This patch fixed the problem.  I am able to run and profile ebizzy on 128-way
> PPC64.  However this fix is not included in 2.6.24-rc2 as well.
> I will watch for inclusion of this fix in 2.6.24.

It's upstream in Linus' tree now, so it will be in -rc3.

Paul.

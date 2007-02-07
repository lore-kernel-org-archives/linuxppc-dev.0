Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 732E4DDEC2
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 18:31:30 +1100 (EST)
Date: Wed, 7 Feb 2007 01:39:13 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: Re: patches in powerpc.git
Message-ID: <20070207073913.GA29151@lixom.net>
References: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,


On Wed, Feb 07, 2007 at 03:03:13PM +1100, Paul Mackerras wrote:
> Paul Mackerras (2):
>       [POWERPC] Clear RI bit in MSR before restoring r13 when returning to userspace
>       [POWERPC] Make pSeries use the H_BULK_REMOVE hypervisor call

On the H_BULK_REMOVE change: Does it show much gains on fork/exit-heavy
workloads?


-Olof

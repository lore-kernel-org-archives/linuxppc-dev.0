Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 95098DDDF5
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 02:08:33 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so870911qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 07:08:31 -0800 (PST)
Date: Fri, 14 Nov 2008 10:08:20 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/virtex: fix various format/casting printk
	mismatches
Message-ID: <20081114150820.GA20645@yoda.jdub.homelinux.org>
References: <20081114045304.15077.72430.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081114045304.15077.72430.stgit@localhost.localdomain>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 13, 2008 at 09:53:04PM -0700, Grant Likely wrote:
>From: Grant Likely <grant.likely@secretlab.ca>
>
>Various printk format string in code used by the Xilinx Virtex platform
>are not 32-bit/64-bit safe.  Add correct casting to fix the bugs.
>
>Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

This fixes the warnings I have been seeing on the ppc40x_defconfig, so:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh

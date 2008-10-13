Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 83269DDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 01:09:13 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c34so119296anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 07:09:09 -0700 (PDT)
Date: Mon, 13 Oct 2008 10:07:42 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs
Message-ID: <20081013140734.GA9793@yoda.jdub.homelinux.org>
References: <20081010025101.B48CADDEF7@ozlabs.org>
	<200810101039.18300.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200810101039.18300.jbarnes@virtuousgeek.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 10:39:18AM -0700, Jesse Barnes wrote:
>On Thursday, October 9, 2008 7:50 pm Benjamin Herrenschmidt wrote:
>> This patch adds support for legacy_io and legacy_mem files in
>> bus class directories in sysfs for powerpc
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>
>Applied to linux-next, thanks.

Is that targeted towards .28 or .29?  Ben has a 4xx specific patch
that depends on this one, and I just need to know which version to
bring that in for.

thx,
josh

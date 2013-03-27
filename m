Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9BE2D2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 07:25:52 +1100 (EST)
Message-ID: <51534942.5020009@zytor.com>
Date: Wed, 27 Mar 2013 12:32:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/3] x86/mm/numa: use setup_nr_node_ids() instead of
 opencoding.
References: <1364319962-30967-1-git-send-email-cody@linux.vnet.ibm.com>
 <1364319962-30967-3-git-send-email-cody@linux.vnet.ibm.com>
 <CAE9FiQVSPdCqaLKapG4DJ1CXtPKb8F29=s_-e9OLpXP7yG1XTA@mail.gmail.com>
In-Reply-To: <CAE9FiQVSPdCqaLKapG4DJ1CXtPKb8F29=s_-e9OLpXP7yG1XTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2013 10:56 AM, Yinghai Lu wrote:
> 
> For 1 and 2,
> 
> Acked-by: Yinghai Lu <yinghai@kernel.org>
> 

Similarly:

Acked-by: H. Peter Anvin <hpa@linux.intel.com>

	-hpa

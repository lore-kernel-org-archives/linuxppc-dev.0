Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 168B42C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 04:50:53 +1000 (EST)
Date: Wed, 21 Aug 2013 11:50:51 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/7] drivers: base: move mutex lock out of
 add_memory_section()
Message-ID: <20130821185051.GA11574@kroah.com>
References: <1377018783-26756-1-git-send-email-sjenning@linux.vnet.ibm.com>
 <20130820172445.GE4151@medulla.variantweb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130820172445.GE4151@medulla.variantweb.net>
Cc: Dave Hansen <dave@sr71.net>, Lai Jiangshan <laijs@cn.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, Yinghai Lu <yinghai@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 20, 2013 at 12:24:45PM -0500, Seth Jennings wrote:
> Gah! Forgot the cover letter.

No worries, I barely read them anyway :)

> This patchset just seeks to clean up and refactor some things in
> memory.c for better understanding and possibly better performance due do
> a decrease in mutex acquisitions and refcount churn at boot time.  No
> functional change is intended by this set!

All looks good, thanks for breaking it up into reviewable patches.  Now
applied.

greg k-h

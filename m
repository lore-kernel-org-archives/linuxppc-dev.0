Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scxrx0vVQzDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 17:11:44 +1000 (AEST)
Date: Mon, 19 Sep 2016 09:11:38 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, matt.fleming@intel.com,
 anju@linux.vnet.ibm.com, mpe@ellerman.id.au, jolsa@kernel.org,
 wangnan0@huawei.com, jpoimboe@redhat.com, mhiramat@kernel.org,
 namhyung@kernel.org
Subject: Re: [PATCH] perf tests: Add dwarf unwind test for powerpc
Message-ID: <20160919071138.GB20798@krava>
References: <1474267100-31079-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474267100-31079-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 19, 2016 at 02:38:20AM -0400, Ravi Bangoria wrote:
> User stack dump feature is recently added for powerpc. But there was no
> test case available to test it. This test works same as other on arch by
> preparing stack frame on perf test thread and comparing each frame by
> unwinding it.
> 
>   $ ./perf test 50
>     50: Test dwarf unwind    : Ok
> 
> User stack dump for powerpc: https://lkml.org/lkml/2016/4/28/482
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

can't test, but looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

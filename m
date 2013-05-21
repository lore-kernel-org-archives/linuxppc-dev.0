Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5182A2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 19:04:13 +1000 (EST)
Message-ID: <519B3855.6050201@asianux.com>
Date: Tue, 21 May 2013 17:03:17 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] PowerPC: kernel: need return the related error code when
 failure occurs.
References: <519B0ACA.6090008@asianux.com>
 <20130521081031.GA29303@iris.ozlabs.ibm.com>
In-Reply-To: <20130521081031.GA29303@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 zhangyanfei@cn.fujitsu.com, Jiri Kosina <jkosina@suse.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/21/2013 04:10 PM, Paul Mackerras wrote:
> On Tue, May 21, 2013 at 01:48:58PM +0800, Chen Gang wrote:
>> > 
>> > When error occurs, need return the related error code to let upper
>> > caller know about it.
>> > 
>> > ppc_md.nvram_size() can return the error code (e.g. core99_nvram_size()
>> > in 'arch/powerpc/platforms/powermac/nvram.c').
>> > 
>> > And when '*ppos >= size', need return -ESPIPE (Illegal seek)
> Why?  When *ppos >= size, it should return 0 (end of file) in my opinion.
> ESPIPE means that any seek would be ineffective, not that a particular
> seek went out of bounds.

OK, thanks, I will send patch v2.  :-)


Thanks.
-- 
Chen Gang

Asianux Corporation

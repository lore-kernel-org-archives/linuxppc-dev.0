Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5289F1A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 16:48:00 +1000 (EST)
Message-ID: <5417DD14.60501@huawei.com>
Date: Tue, 16 Sep 2014 14:47:48 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 5/5] MSI: Use __read_msi_msg() instead of read_msi_msg()
References: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>	
 <1408694880-8260-6-git-send-email-wangyijing@huawei.com>
 <1410849257.12488.3.camel@concordia>
In-Reply-To: <1410849257.12488.3.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/9/16 14:34, Michael Ellerman wrote:
> On Fri, 2014-08-22 at 16:08 +0800, Yijing Wang wrote:
>> Read_msi_msg() only be called in rtas_setup_msi_irqs(),
>> use __read_msi_msg() instead of read_msi_msg for
>> simplification. And rename __read_msi_msg() to
>> read_msi_msg().
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: linuxppc-dev@lists.ozlabs.org
> 
> LGTM.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks!

> 
> cheers
> 
> 
> 
> 


-- 
Thanks!
Yijing

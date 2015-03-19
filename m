Return-Path: <weiyang.kernel@gmail.com>
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com
 [IPv6:2607:f8b0:4003:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DC041A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:49:41 +1100 (AEDT)
Received: by oiag65 with SMTP id g65so78650193oia.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 16:49:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6+d4W5wXEP8qoPN3S3tEYpFoOvg==ES922J_miisshXw@mail.gmail.com>
References: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1425446353-30513-16-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150311135507.GA16664@google.com> <20150312011517.GA5833@richard>
 <20150319150824.GE26935@google.com>
 <CADLM8XOFfQmfEXeqObNatGmvonFRF29RVyhhOaKaxzdYxpHoEw@mail.gmail.com>
 <CAErSpo6+d4W5wXEP8qoPN3S3tEYpFoOvg==ES922J_miisshXw@mail.gmail.com>
Date: Fri, 20 Mar 2015 07:49:38 +0800
Message-ID: <CADLM8XNxRgpKFa9JE8vCge2vT9xK_4aorcku9RbCs5eP8o2kaQ@mail.gmail.com>
Subject: Re: [PATCH V13 15/21] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
From: Wei Yang <weiyang.kernel@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-03-20 1:54 GMT+08:00 Bjorn Helgaas <bhelgaas@google.com>:
> On Thu, Mar 19, 2015 at 11:18 AM, Wei Yang <weiyang.kernel@gmail.com> wrote:
>> Oh, I thought you are not comfortable with the "Patch v12 10/21 PCI:
>> Consider additional PF's IOV BAR alignment ..."
>>
>> V14 is ready to send which is based on v4.0-rc1.
>
> Unless I missed something, the last email in that thread [1] is from
> you, so I think we're ready for the next iteration.
>
> [1] http://lkml.kernel.org/r/20150224083406.32124.65957.stgit@bhelgaas-glaptop2.roam.corp.google.com


Great~~~ I thought you didn't get a chance to read it.

Will send out a v14 ASAP.


-- 
Richard Yang
Help You, Help Me

Return-Path: <bhelgaas@google.com>
Received: from mail-qc0-x22f.google.com (mail-qc0-x22f.google.com
 [IPv6:2607:f8b0:400d:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 286091A09D9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 04:54:57 +1100 (AEDT)
Received: by qcbkw5 with SMTP id kw5so73227231qcb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 10:54:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADLM8XOFfQmfEXeqObNatGmvonFRF29RVyhhOaKaxzdYxpHoEw@mail.gmail.com>
References: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1425446353-30513-16-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150311135507.GA16664@google.com> <20150312011517.GA5833@richard>
 <20150319150824.GE26935@google.com>
 <CADLM8XOFfQmfEXeqObNatGmvonFRF29RVyhhOaKaxzdYxpHoEw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 19 Mar 2015 12:54:33 -0500
Message-ID: <CAErSpo6+d4W5wXEP8qoPN3S3tEYpFoOvg==ES922J_miisshXw@mail.gmail.com>
Subject: Re: [PATCH V13 15/21] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
To: Wei Yang <weiyang.kernel@gmail.com>
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

On Thu, Mar 19, 2015 at 11:18 AM, Wei Yang <weiyang.kernel@gmail.com> wrote:
> Oh, I thought you are not comfortable with the "Patch v12 10/21 PCI:
> Consider additional PF's IOV BAR alignment ..."
>
> V14 is ready to send which is based on v4.0-rc1.

Unless I missed something, the last email in that thread [1] is from
you, so I think we're ready for the next iteration.

[1] http://lkml.kernel.org/r/20150224083406.32124.65957.stgit@bhelgaas-glaptop2.roam.corp.google.com

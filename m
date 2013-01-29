Return-Path: <michael@ellerman.id.au>
Message-ID: <1359457108.26096.7.camel@concordia>
Subject: Re: [PATCH 2/2] pseries/iommu: remove DDW on kexec
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Tue, 29 Jan 2013 21:58:28 +1100
In-Reply-To: <20130129020357.GB12156@linux.vnet.ibm.com>
References: <20130129020245.GA12156@linux.vnet.ibm.com>
 <20130129020357.GB12156@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: miltonm@bga.com, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-01-28 at 18:03 -0800, Nishanth Aravamudan wrote:
> pseries/iommu: remove DDW on kexec
>  ...
>     
> I believe the simplest, easiest-to-maintain fix is to just change our
> initcall to, rather than detecting and updating the new kernel's DDW
> knowledge, just remove all DDW configurations. When the drivers
> re-initialize, we will set everything back up as it was before.

I don't know this code at all, but this sounds like it will also work
for kdump, right? ie. when the original kernel has crashed the 2nd
kernel will tear the DDW down and set it back up.

cheers

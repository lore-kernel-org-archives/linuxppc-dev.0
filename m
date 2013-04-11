Return-Path: <chris.friesen@genband.com>
Received: from exprod7og125.obsmtp.com (exprod7og125.obsmtp.com [64.18.2.28])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4B5F52C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 06:00:44 +1000 (EST)
Message-ID: <51671636.5080300@genband.com>
Date: Thu, 11 Apr 2013 13:59:50 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: recommended method of netbooting kernel/dtb in u-boot?
References: <5166DA49.5000907@genband.com>
 <3B81A930-A4AB-4AA7-BC36-FCCE55D33C66@kernel.crashing.org>
 <51670344.2090101@genband.com> <20130411195019.GA31025@ovro.caltech.edu>
In-Reply-To: <20130411195019.GA31025@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2013 01:50 PM, Ira W. Snyder wrote:

> I use a hardware setup which sounds similar to yours. The DHCP server
> controls which file is sent to each card.
>
> I use the FIT image format to combine a kernel, dtb, and initrd in one
> package.
>
> <snip>
>
> I used the U-Boot doc/uImage.FIT/*.its examples to get started, and
> wrote my own custom .its file for my board. I don't use anything other
> than the vmlinux.bin.gz provided by the kernel build.

Okay, that's a good data point, thanks.

Chris

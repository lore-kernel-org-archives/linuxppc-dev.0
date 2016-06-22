Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZQYg3gzFzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 23:34:31 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 66so4119500pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 06:34:31 -0700 (PDT)
Date: Wed, 22 Jun 2016 23:29:46 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
Message-ID: <20160622232946.793d6c04@350D>
In-Reply-To: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Jun 2016 16:48:32 -0300
Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:

> Hello,
> 
> This patch series implements the kexec_file_load system call on
> PowerPC.
> 
> This system call moves the reading of the kernel, initrd and the
> device tree from the userspace kexec tool to the kernel. This is
> needed if you want to do one or both of the following:
> 
> 1. only allow loading of signed kernels.
> 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
>    command line and other boot inputs for the Integrity Measurement
>    Architecture subsystem.
> 
> The above are the functions kexec already has built into
> kexec_file_load. Yesterday I posted a set of patches which allows a
> third feature:
> 
> 3. have IMA pass-on its event log (where integrity measurements are
>    registered) accross kexec to the second kernel, so that the event
>    history is preserved.

OK.. and this is safe? Do both the kernels need to be signed by the
same certificate?


Balbir Singh

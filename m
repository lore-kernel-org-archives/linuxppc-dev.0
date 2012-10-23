Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp16.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F300A2C0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 17:55:20 +1100 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Tue, 23 Oct 2012 07:55:14 +0100
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9N6t4YN55509126
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 06:55:04 GMT
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9N6tB3Q009969
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 00:55:11 -0600
Date: Tue, 23 Oct 2012 08:55:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Build regressions/improvements in v3.7-rc2
Message-ID: <20121023065548.GA4164@osiris.de.ibm.com>
References: <alpine.DEB.2.00.1210222146440.12209@ayla.of.borg>
 <CAMuHMdVS-qz0BAHXFGD01+w1GxyQ2M7DpLnLRQKtdZSiDfYgHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdVS-qz0BAHXFGD01+w1GxyQ2M7DpLnLRQKtdZSiDfYgHw@mail.gmail.com>
Cc: linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2012 at 09:50:26PM +0200, Geert Uytterhoeven wrote:
> On Mon, Oct 22, 2012 at 9:47 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v3.7-rc2 to v3.7-rc1[3], the summaries are:
> >   - build errors: +4/-44
> 
>   + arch/s390/include/asm/kvm_para.h: error: redefinition of
> 'kvm_arch_para_features':  => 147:28, 147:99
>   + arch/s390/include/asm/kvm_para.h: error: redefinition of
> 'kvm_check_and_clear_guest_paused':  => 152:91, 152:20
> 
> s390-allmodconfig/s390-allyesconfig/s390-defconfig

Thanks Geert. We have already a build fix for this from David Howells
which is waiting to be merged upstream.

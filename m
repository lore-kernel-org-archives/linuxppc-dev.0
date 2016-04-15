Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmY3k6MbPzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 20:01:54 +1000 (AEST)
Message-ID: <1460714506.22415.0.camel@ellerman.id.au>
Subject: Re: Live patching for powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@redhat.com>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jikos@kernel.org,
 live-patching@vger.kernel.org
Date: Fri, 15 Apr 2016 20:01:46 +1000
In-Reply-To: <alpine.LNX.2.00.1604151018220.4334@pobox.suse.cz>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604131457180.16586@pobox.suse.cz>
 <20160413182228.GA16776@packer-debian-8-amd64.digitalocean.com>
 <alpine.LNX.2.00.1604141514420.10605@pobox.suse.cz>
 <20160414192031.GB25297@packer-debian-8-amd64.digitalocean.com>
 <alpine.LNX.2.00.1604151018220.4334@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-15 at 10:28 +0200, Miroslav Benes wrote:
> On Thu, 14 Apr 2016, Jessica Yu wrote:
> > For the 32-bit module code, I don't believe we would need to preserve
> > the .init.plt section for livepatch's call to apply_relocate_add(),
> > since relocations to init sections should've been applied during
> > module initialization, and we don't patch those types of functions.
> > Please correct me if my understanding is off.
> 
> I think you are right, but I also think we don't have to worry about 
> 32-bit powerpc anyway. This patch set supports ppc64le only so we can 
> leave it for now.

Yep. Who ever wants to do 32-bit live patch support can cross that bridge when
they come to it.

cheers

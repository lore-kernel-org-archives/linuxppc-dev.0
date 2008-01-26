Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 021F8DDDEB
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 07:46:47 +1100 (EST)
Date: Sat, 26 Jan 2008 12:45:14 -0800
From: Greg KH <greg@kroah.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUILD FAILURE]2.6.24-git{1,2} kernel powerpc linkage failure
Message-ID: <20080126204514.GB30867@kroah.com>
References: <479B3453.3030105@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <479B3453.3030105@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 26, 2008 at 06:53:31PM +0530, Kamalesh Babulal wrote:
> Hi,
> 
> The 2.6.24-git2 kernel build fails on the power boxes with following build failure
> 
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/powerpc/kernel/built-in.o: In function `fphalf':
> arch/powerpc/kernel/vector.S:(.toc+0x1428): undefined reference to `devices_subsys'
> make: *** [.tmp_vmlinux1] Error 1
> 
> This built-failure was seen in the mm broken-out-2007-11-06-02-32, I have tested 
> the patch posted to lkml at http://lkml.org/lkml/2007/11/6/208 fixes this issue.

And that patch is wrong, see my post on lkml about this yesterday.

Paul is working on a "correct" patch, and if I get some time this
afternoon, I'll do one too.

thanks,

greg k-h

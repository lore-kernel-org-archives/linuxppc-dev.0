Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrXnZ4VcpzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 23:03:46 +1000 (AEST)
Date: Fri, 15 Jul 2016 09:03:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 bhe@redhat.com, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 bauerman@linux.vnet.ibm.com, Dave Young <dyoung@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160715130342.GB23514@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <5352106.oQ0Ff9gWJA@wuerfel> <20160713094127.GC14522@leverpostej>
 <7352796.seiSnHrYPy@wuerfel>
 <20160715084925.GD1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715084925.GD1041@n2100.armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 15, 2016 at 09:49:25AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 13, 2016 at 03:13:42PM +0200, Arnd Bergmann wrote:
> > On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > > The big question is whether this is a realistic case on a secure boot
> > > system.
> > 
> > What does x86 do here? I assume changes to the command line are also
> > limited.
> 
> They aren't.  You can specify /anything/ even with a fully-signed kernel
> and initrd, which was one of the things I pointed out in my previous
> set of responses.

Yes, kernel command line is not signed. For that matter even initird is
not signed. Just kernel is signed and its signatures are verified. Idea
is an unsigned code should not be able to execute in kernel space.

Vivek

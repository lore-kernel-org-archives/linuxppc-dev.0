Return-Path: <michael@ellerman.id.au>
Date: Tue, 5 Mar 2013 11:28:57 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Enable multiple MSI feature in pSeries
Message-ID: <20130305002857.GA7656@concordia>
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1362107325.2712.2.camel@localhost>
 <20130301035417.GA17236@concordia>
 <513411AD.5010408@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <513411AD.5010408@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 04, 2013 at 11:14:53AM +0800, Mike Qiu wrote:
> 于 2013/3/1 11:54, Michael Ellerman 写道:
> >On Fri, Mar 01, 2013 at 11:08:45AM +0800, Mike wrote:
> >>Hi all
> >>
> >>Any comments? or any questions about my patchset?
> >You were going to get some performance numbers that show a definite
> >benefit for using more than one MSI.

> Yes, but my patch just enable the kernel to support this feature, whether
> to use it depens on the device driver.

Sure, but we don't add code just for fun, so unless there's a good
reason to add the feature - like better performance - we won't bother.

> And this feature has been merged to the kernel for X86 for a long time.
> See commit: 5ca72c4f7c412c2002363218901eba5516c476b1
> 51906e779f2b13b38f8153774c4c7163d412ffd9

That commit was merged in 3.9-rc1, ie. a few days ago, so no it has not been
in x86 for a long time.

That code removes the need for your first patch, which is a good start.
Please send a new version using irq_set_msi_desc_off().

cheers

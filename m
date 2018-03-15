Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0091.hostedemail.com
 [216.40.44.91])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402Bg15hwzzF1N4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 02:03:24 +1100 (AEDT)
Message-ID: <1521126196.22221.10.camel@perches.com>
Subject: Re: [PATCH] powerpc: Use common error handling code in setup_new_fdt()
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Borislav Petkov <bp@suse.de>, Brijesh Singh
 <brijesh.singh@amd.com>, Josh Sklar <sklar@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Tom
 Lendacky <thomas.lendacky@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Date: Thu, 15 Mar 2018 08:03:16 -0700
In-Reply-To: <20180315115753.rjejlkrp3fhdxbyk@mwanda>
References: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
 <87fu52jqtc.fsf@morokweng.localdomain>
 <20180315115753.rjejlkrp3fhdxbyk@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-15 at 14:57 +0300, Dan Carpenter wrote:
> On Wed, Mar 14, 2018 at 06:22:07PM -0300, Thiago Jung Bauermann wrote:
> > 
> > SF Markus Elfring <elfring@users.sourceforge.net> writes:
> > 
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Sun, 11 Mar 2018 09:03:42 +0100
> > > 
> > > Add a jump target so that a bit of exception handling can be better reused
> > > at the end of this function.
> > > 
> > > This issue was detected by using the Coccinelle software.
> > > 
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > ---
> > >  arch/powerpc/kernel/machine_kexec_file_64.c | 28 ++++++++++++----------------
> > >  1 file changed, 12 insertions(+), 16 deletions(-)
> > 
> > I liked it. Thanks!
> > 
> > Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > 
> 
> You know that compilers already re-use string constants so this doesn't
> actually save memory?

And modern compilers create their own jump labels
so this doesn't change object code either?

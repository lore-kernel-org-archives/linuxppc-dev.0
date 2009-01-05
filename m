Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 6EC8EDE0AE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 02:28:57 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so5513783rnf.16
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Jan 2009 07:28:56 -0800 (PST)
Message-ID: <fa686aa40901050728w3bb34bamd66345181fed76d6@mail.gmail.com>
Date: Mon, 5 Jan 2009 08:28:56 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Copy bootable images in the default install
	script
In-Reply-To: <20090105150025.GA26783@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081220005720.23861.18505.stgit@localhost.localdomain>
	<20090105150025.GA26783@zod.rchland.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
	LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 5, 2009 at 8:00 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
>
> On Fri, Dec 19, 2008 at 05:57:20PM -0700, Grant Likely wrote:
> >From: Grant Likely <grant.likely@secretlab.ca>
> >
> >This patch makes the default install script (arch/powerpc/boot/install.sh)
> >copy the bootable image files into the install directory.  Before this
> >patch only the vmlinux image file was copied.
>
> What do you do for cases where there isn't a single file?  E.g. a
> canyonlands board will need both the uImage and caynonlands.dtb files
> to be "installed".  U-Boot needs to be provided with both of them.

That is exactly what this patch does.  It copies all of the image
files in $(image-y).

g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

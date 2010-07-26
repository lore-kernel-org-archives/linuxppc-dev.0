Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 7682D10083B
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 08:06:44 +1000 (EST)
Date: Mon, 26 Jul 2010 15:05:13 -0700
From: Greg KH <gregkh@suse.de>
To: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/2 v1.03] Add support for DWC OTG HCD function.
Message-ID: <20100726220513.GA9671@suse.de>
References: <12801701823001-git-send-email-fchen@apm.com>
	<20100726213704.GA16268@suse.de>
	<4C4E0449.2070108@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C4E0449.2070108@caviumnetworks.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 02:55:21PM -0700, David Daney wrote:
> On 07/26/2010 02:37 PM, Greg KH wrote:
> [...]
> >>+/*
> >>+ * DesignWare HS OTG controller driver
> >>+ *
> >>+ * Author: Mark Miesfeld<mmiesfeld@apm.com>
> >>+ *
> >>+ * Based on versions provided by APM and Synopsis which are:
> >>+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
> >>+ * Modified by Stefan Roese<sr@denx.de>, DENX Software Engineering
> >>+ *
> >>+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
> >>+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
> >>+ * otherwise expressly agreed to in writing between Synopsys and you.
> >
> >WTF?
> >
> 
> I was not involved with this version of the patch, but is it really
> that bad?

You tell me, how does that interact with the GPL?

Do you want to be in charge of getting that "approval in writing" from
every single user of Linux and Synopsys so that this is somehow not a
"proprietary work of Synopsys, Inc."?


> >Um, I think someone needs to rethink this submission, as this really
> >doesn't look like GPL code...
> >
> >Oh, and where do I go get that "writing" between me and Synopsys to fix
> >this up?  :)
> >
> >>+ * The Software IS NOT an item of Licensed Software or Licensed Product under
> >>+ * any End User Software License Agreement or Agreement for Licensed Product
> >>+ * with Synopsys or any supplement thereto. You are permitted to use and
> >>+ * redistribute this Software in source and binary forms, with or without
> >>+ * modification, provided that redistributions of source code must retain this
> >>+ * notice. You may not view, use, disclose, copy or distribute this file or
> >>+ * any information contained herein except pursuant to this license grant from
> >>+ * Synopsys. If you do not agree with this notice, including the disclaimer
> >>+ * below, then you are not authorized to use the Software.
> >
> >Same here, what is going on?
> 
> First of all, I am not a Lawyer, so take this with a grain of salt
> if you wish.
> 
> How is this different than a 3-clause BSD License?  There are other
> instances of BSD Licensed code in the kernel (see
> include/linux/quota.h for example).

That's wonderful, then license it under the 3-clause BSD license.  Don't
make up something else :)

If that's what is happening here, then document it as such.

> >Has someone run this through the proper legal approval to make public?
> >If so, someone needs to go kick a lawyer.  If not, they just got in big
> >trouble...
> >
> >>+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
> >>+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> >>+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> >>+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
> >>+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> >>+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> >>+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> >>+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> >>+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> >>+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> >>+ * DAMAGE.
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify
> >>+ * it under the terms of the GNU General Public License version 2 as
> >>+ * published by the Free Software Foundation.
> >>+ *
> >>+ * This program is distributed in the hope that it will be useful, but
> >>+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> >>+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> >>+ * for more details.
> >>+ *
> >>+ * You should have received a copy of the GNU General Public License
> >>+ * along with this program; if not, write to the Free Software Foundation,
> >>+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> >
> >
> >It's fun to just tack on the GPL boilerplate on a file, but when it
> >conflicts with other stuff in the same file, it kind of just makes us
> >all go crazy.
> >
> 
> Indeed that part does seem questionable.  Could it be used with the
> original Synopsys license, without tacking on this GPL bit?

Um, no.

Please, someone needs to go run this past the Synopsys lawyers (yeah,
sorry, that's horrible to do, but it needs to be done to get it
correct.)

Because of this, I'd like to get a lawyer's signed-off-by on the code as
well just to verify that it's all ok.

Yes, that's a pain, but we gotta make sure that everyone involved knows
_exactly_ what is going on here, and this mess of header garbage shows
that no one knows what is happening.

thanks,

greg k-h

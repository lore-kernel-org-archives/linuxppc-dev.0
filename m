Return-Path: <yong.zhang0@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB3F8B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 17:08:36 +1000 (EST)
Received: by yxm34 with SMTP id 34so877529yxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 00:08:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110629064635.GB678@in.ibm.com>
References: <BANLkTi=gx73d6-s-jqeke05SQYorpnzLVw@mail.gmail.com>
	<1308911347.531.56.camel@gandalf.stny.rr.com>
	<4E074671.7060100@hitachi.com> <20110627100104.GA24705@in.ibm.com>
	<BANLkTimYej4_dmBqvPBCLej=JA5atLrZVA@mail.gmail.com>
	<20110629064635.GB678@in.ibm.com>
Date: Thu, 30 Jun 2011 15:08:32 +0800
Message-ID: <BANLkTi=XZuV+UgBT9xdQ14YYL=16fwXvuA@mail.gmail.com>
Subject: Re: [BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu'
	lead to system crash/freeze
From: Yong Zhang <yong.zhang0@gmail.com>
To: ananth@in.ibm.com
Content-Type: text/plain; charset=UTF-8
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, paulus@samba.org,
	yrl.pp-manager.tt@hitachi.com,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2011 at 2:46 PM, Ananth N Mavinakayanahalli
<ananth@in.ibm.com> wrote:
>
> Certain functions are off limits for probing -- look for __kprobe

Yup.

> annotations in the kernel. Some such functions are arch specific, but
> show_interrupts() would definitely not be one of them. It works fine on
> my (64bit) test box.
>
> At this time, I think your best bet is to work with the eldk folks to
> narrow down the problem.

I'll give a try :)

> Given the current set of data, I am inclined to
> think it could be an eldk bug, not a kernel one.

Maybe, but the fact is if I don't use kprobe, things works
very well.

I'll be back if there is any update :)

Thanks,
Yong

-- 
Only stand for myself

Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id C5AE7B6F5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 23:15:50 +1000 (EST)
Subject: Re: [BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu'
	lead to system crash/freeze
From: Steven Rostedt <rostedt@goodmis.org>
To: ananth@in.ibm.com
In-Reply-To: <20110628104128.GA4310@in.ibm.com>
References: <BANLkTi=gx73d6-s-jqeke05SQYorpnzLVw@mail.gmail.com>
	<1308911347.531.56.camel@gandalf.stny.rr.com>
	<4E074671.7060100@hitachi.com> <20110627100104.GA24705@in.ibm.com>
	<20110628104128.GA4310@in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Tue, 28 Jun 2011 09:15:45 -0400
Message-ID: <1309266945.26417.2.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Yong Zhang <yong.zhang0@gmail.com>, paulus@samba.org,
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

On Tue, 2011-06-28 at 16:11 +0530, Ananth N Mavinakayanahalli wrote:

> My access to a 32bit powerpc box is very limited. Also, embedded powerpc
> has had issues with gcc-4.6 while gcc-4.5 worked fine.

I'd work to debug this too, but I don't have access to a 32bit ppc
either. Although I've been told that people would send me one ;)

-- Steve

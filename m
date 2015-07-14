Return-Path: <dwalker@fifo99.com>
Received: from ip-172-31-12-36.us-west-2.compute.internal
 (ec2-54-201-57-178.us-west-2.compute.amazonaws.com [54.201.57.178])
 by lists.ozlabs.org (Postfix) with ESMTP id C15881A025F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 23:59:37 +1000 (AEST)
Date: Tue, 14 Jul 2015 13:59:19 +0000
From: dwalker@fifo99.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vivek Goyal <vgoyal@redhat.com>, linux-mips@linux-mips.org,
 Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
Message-ID: <20150714135919.GA18333@fifo99.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h9p7r0we.fsf@x220.int.ebiederm.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> dwalker@fifo99.com writes:
> 
> > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> >> 
> >> > You can call panic notifiers and kmsg dumpers before kdump by
> >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> >> > However, it doesn't make sense if kdump is not available.  In that
> >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> >> > you can't change the value of the parameter.
> >> 
> >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > I think it would make sense if he just replaced "kdump" with "kexec".
> 
> It would be less insane, however it still makes no sense as without
> kexec on panic support crash_kexec is a noop.  So the value of the
> seeting makes no difference.

Can you explain more, I don't really understand what you mean. Are you suggesting
the whole "crash_kexec_post_notifiers" feature has no value ?

Daniel

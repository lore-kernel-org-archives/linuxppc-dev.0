Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id ACFD667B59
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 00:43:38 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id p48so625761nfa
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 07:43:36 -0700 (PDT)
Message-ID: <787b0d920608160743t60ba42b7m5dd1426e0ee1f576@mail.gmail.com>
Date: Wed, 16 Aug 2006 10:43:36 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
In-Reply-To: <17634.64640.709200.871907@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
	<000301c6bf97$e9151e00$99dfdfdf@bakuhatsu.net>
	<17633.18057.778991.483461@cargo.ozlabs.ibm.com>
	<20060816105925.GB21865@iram.es>
	<17634.64640.709200.871907@cargo.ozlabs.ibm.com>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/16/06, Paul Mackerras <paulus@samba.org> wrote:
> Gabriel Paubert writes:

> > BTW, there is one way to make pages non executable: mark
> > them as guarded, but it will have a significant cost in
> > terms of performance.
>
> Indeed.  I guess we could do that as a config option for machines that
> really want maximum security at the expense of performance, but I
> don't think all users would want that.

On the other hand, if you want to squeeze some performance
out of the chip, turn off coherency. (probably not for SMP)

I've done it before, with a non-Linux OS. It does help.

Other tricks are to map userspace via BATs and, on the 7410
at least, to map half or all of the outermost cache memory as
a special block of high-speed memory.

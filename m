Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYM4l42m2zDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 15:53:59 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qYM4l2CbGz9s9k
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 15:53:59 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Mon, 28 Mar 2016 14:53:58 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F03D12BB0055
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 15:53:49 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2S4raF557868404
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 15:53:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2S4rBld005130
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 15:53:12 +1100
Date: Mon, 28 Mar 2016 10:22:51 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Torsten Duwe <duwe@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH HACK 1/6] livepatch-test: Add more cases
Message-ID: <20160328045249.GA12521@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <20160324163734.GA7493@linux.vnet.ibm.com>
 <CAKTCnz=8giVb4_mdrPj0V1XvAnzpxLXZ9-XuJwB+R2NM16ZdzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAKTCnz=8giVb4_mdrPj0V1XvAnzpxLXZ9-XuJwB+R2NM16ZdzA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Balbir Singh <bsingharora@gmail.com> [2016-03-26 18:11:22]:

> On Fri, Mar 25, 2016 at 3:37 AM, Kamalesh Babulal
> <kamalesh@linux.vnet.ibm.com> wrote:
> > * Michael Ellerman <mpe@ellerman.id.au> [2016-03-24 22:04:00]:
> >
> >> Not for merging.
> >>
> >
> > Hi Michael,
> >
> > Loading the livepatch sample module, trigger following warning
> >
> 
> The #if IS_MODULE(CONFIG_SCSI) code is buggy, you probably have
> CONFIG_SCSI=y, make it M or you can fix the code yourself. I had the
> same issue while testing
> 
> BTW, the tests worked fine with the changes proposed by Michael.
> 

Thanks, It helped. I was able to load the sample livepatch module
with proposed changes.

Thanks,
Kamalesh.

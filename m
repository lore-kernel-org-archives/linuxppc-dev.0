Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 78B70B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 09:58:21 +1000 (EST)
Date: Tue, 26 Jun 2012 19:58:04 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [linux-pm] [PATCH -v4 6/6] fault-injection: add notifier error
 injection testing scripts
Message-ID: <20120626235804.GA7525@redhat.com>
References: <1340463502-15341-1-git-send-email-akinobu.mita@gmail.com>
 <1340463502-15341-7-git-send-email-akinobu.mita@gmail.com>
 <20120626163147.93181e21.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120626163147.93181e21.akpm@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, Akinobu Mita <akinobu.mita@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>,
 linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2012 at 04:31:47PM -0700, Andrew Morton wrote:

 > My overall take on the fault-injection code is that there has been a
 > disappointing amount of uptake: I don't see many developers using them
 > for whitebox testing their stuff.  I guess this patchset addresses
 > that, in a way.

I added support for make-it-fail to my syscall fuzzer a while ago.
(if the file exists, the child processes set it before calling the fuzzed syscall).
I've not had a chance to really play with it, because I find enough problems
already even without it.

	Dave

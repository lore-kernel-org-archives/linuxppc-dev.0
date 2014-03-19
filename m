Return-Path: <eparis@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 0FED52C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 10:02:31 +1100 (EST)
Message-ID: <1395270144.10106.0.camel@localhost>
Subject: Re: [PATCH 3/4] ARCH: AUDIT: implement syscall_get_arch for all arches
From: Eric Paris <eparis@redhat.com>
To: Matt Turner <mattst88@gmail.com>
Date: Wed, 19 Mar 2014 19:02:24 -0400
In-Reply-To: <CAEdQ38Ex47GxhN1ZZMu+RETpWs-ENbfCr8v=6iFg9p_QWaa9zw@mail.gmail.com>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com>
 <1395266643-3139-3-git-send-email-eparis@redhat.com>
 <CAEdQ38Ex47GxhN1ZZMu+RETpWs-ENbfCr8v=6iFg9p_QWaa9zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 linux-ia64@vger.kernel.org,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 microblaze-uclinux@itee.uq.edu.au, linux@openrisc.net, linux-audit@redhat.com,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-19 at 15:19 -0700, Matt Turner wrote:
> On Wed, Mar 19, 2014 at 3:04 PM, Eric Paris <eparis@redhat.com> wrote:
> > For all arches which support audit implement syscall_get_arch()
> 
> support audit -- is that AUDIT_ARCH? If so, alpha gained support
> recently, so I think this patch needs to handle alpha too?

Absolutely right.  I broke Alpha (in the next patch).  Will fix.

-Eric

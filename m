Return-Path: <mattst88@gmail.com>
Received: from mail-qc0-x230.google.com (mail-qc0-x230.google.com
 [IPv6:2607:f8b0:400d:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E3DBC2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:20:16 +1100 (EST)
Received: by mail-qc0-f176.google.com with SMTP id m20so10739999qcx.35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Mar 2014 15:20:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395266643-3139-3-git-send-email-eparis@redhat.com>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com>
 <1395266643-3139-3-git-send-email-eparis@redhat.com>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 19 Mar 2014 15:19:51 -0700
Message-ID: <CAEdQ38Ex47GxhN1ZZMu+RETpWs-ENbfCr8v=6iFg9p_QWaa9zw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARCH: AUDIT: implement syscall_get_arch for all arches
To: Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Wed, Mar 19, 2014 at 3:04 PM, Eric Paris <eparis@redhat.com> wrote:
> For all arches which support audit implement syscall_get_arch()

support audit -- is that AUDIT_ARCH? If so, alpha gained support
recently, so I think this patch needs to handle alpha too?

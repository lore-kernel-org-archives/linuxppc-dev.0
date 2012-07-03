Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 4B5E62C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 06:41:22 +1000 (EST)
Date: Tue, 3 Jul 2012 13:41:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH -v5 0/6] notifier error injection
Message-Id: <20120703134120.dc89c7ae.akpm@linux-foundation.org>
In-Reply-To: <1341035970-20490-1-git-send-email-akinobu.mita@gmail.com>
References: <1341035970-20490-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>,
 =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>,
 linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Jun 2012 14:59:24 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This provides kernel modules that can be used to test the error handling
> of notifier call chain failures by injecting artifical errors to the
> following notifier chain callbacks.

No updates to Documentation/fault-injection/?

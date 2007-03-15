Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 06518DDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:45:17 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so41920nfc
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 16:45:14 -0700 (PDT)
Message-ID: <528646bc0703151645xb45d70cg8e96d437540ff6@mail.gmail.com>
Date: Thu, 15 Mar 2007 17:45:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: RFC: arch/powerpc Kconfig cleanup
In-Reply-To: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/15/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> arch/powerpc/Kconfig has become something of a mess and platform support
> is scattered between it and various arch/powerpc/platforms/*/Kconfig
> files.  I've got some ideas on some simple clean up that will introduce a
> arch/powerpc/platforms/Kconfig and pull out platform config information
> from arch/powerpc/Kconfig.
>
> Beyond general cleanup, there are several config options that should
> exist under the "Platform support" menu but end up getting duplicated
> across sub-architectures (QE, CPM2, etc.)
>
> By introducing a platforms/Kconfig we will have a place to put those
> config options so we don't have to duplicate them.

I'm all for this, go for it!

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

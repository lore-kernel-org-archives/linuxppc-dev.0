Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0047.hostedemail.com
 [216.40.44.47])
 by lists.ozlabs.org (Postfix) with ESMTP id 1541A1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 04:03:43 +1100 (AEDT)
Date: Tue, 10 Mar 2015 13:03:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
Message-ID: <20150310130337.56330818@gandalf.local.home>
In-Reply-To: <1425947283.19022.8.camel@ellerman.id.au>
References: <20150305171239.3a8135e6@gandalf.local.home>
 <1425615522.4636.173.camel@kernel.crashing.org>
 <20150306100021.5637d790@gandalf.local.home>
 <1425682582.4636.197.camel@kernel.crashing.org>
 <CAOesGMjBjmVQtdA85Uc2QrVT6enVShOx-iyXdZLvH9vuq8t=wQ@mail.gmail.com>
 <1425700921.4636.213.camel@kernel.crashing.org>
 <1425947283.19022.8.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Mar 2015 11:28:03 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> 
> Mine is running:
> 
>   CFE version PAS-2.0.29 for ATHENA (64bit,MP,BE,PPC)
>   Build Date: Mon Jun 30 11:47:25 PDT 2008 (mpl@mitch-1)
> 
> Steve is your CFE older than that?

Seems so:

CFE version PAS-2.0.20 for ELECTRA (64bit,MP,BE,PPC)
Build Date: Tue Nov  6 22:35:48 PST 2007 (mpl@mitch-1)

-- Steve

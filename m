Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0040.hostedemail.com
 [216.40.44.40])
 by lists.ozlabs.org (Postfix) with ESMTP id 1D7A01A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 10:07:30 +1100 (AEDT)
Date: Fri, 6 Mar 2015 18:07:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
Message-ID: <20150306180726.1ce085e8@gandalf.local.home>
In-Reply-To: <1425682582.4636.197.camel@kernel.crashing.org>
References: <20150305171239.3a8135e6@gandalf.local.home>
 <1425615522.4636.173.camel@kernel.crashing.org>
 <20150306100021.5637d790@gandalf.local.home>
 <1425682582.4636.197.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 07 Mar 2015 09:56:22 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:


> In the meantime, try that patch:
> 

It boots for me.

Tested-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

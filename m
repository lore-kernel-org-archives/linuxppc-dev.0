Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7E2722C032E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 21:16:40 +1100 (EST)
Message-ID: <1381400194.4330.46.camel@pasglop>
Subject: Re: [PATCH 2/3] powerpc/scom: Replace debugfs interface with
 cleaner sysfs one
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Thu, 10 Oct 2013 21:16:34 +1100
In-Reply-To: <20131010100640.GA9906@iris.ozlabs.ibm.com>
References: <1381393115.4330.39.camel@pasglop>
 <20131010100640.GA9906@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-10 at 21:06 +1100, Paul Mackerras wrote:
> On Thu, Oct 10, 2013 at 07:18:35PM +1100, Benjamin Herrenschmidt wrote:
> > The debugfs interface was essentially unused, and racy for anything
> > other than manual use by a developer. This provides a more useful
> > sysfs based one which can be used by programs without racing with
> > each other essentially by providing a file to read/write with an
> > offset being the scom address << 8.
> 
> Don't you mean address << 3 (or address * 8)?

Yes, typo in the comment, the code is fine. I was tired :)

Cheers,
Ben.

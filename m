Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zDGZs2Gm8zF0Rg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jan 2018 20:34:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Spectre+Meltdown
In-Reply-To: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
Date: Sat, 06 Jan 2018 20:34:28 +1100
Message-ID: <874lnzz5y3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Hi All,
>
> Do we have some information regarding Spectre+Meltdown for our users?
>
> It could be that we have some security issues in our PowerPC CPUs.

There's a statement from IBM here:

  https://www.ibm.com/blogs/psirt/potential-impact-processors-power-family/


I think you're mostly using pasemi CPUs right? I don't have any
information on them, and obviously it's going to be hard to find anyone
who might know. You might be best finding a proof of concept somewhere
and actually testing it.

cheers

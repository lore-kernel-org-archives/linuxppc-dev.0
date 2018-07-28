Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cnF85djtzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 10:45:48 +1000 (AEST)
Message-ID: <63673ded743508a49436a1108e2f69142d6a3579.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, ray.jui@broadcom.com, Paul Mackerras
 <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Sat, 28 Jul 2018 10:45:22 +1000
In-Reply-To: <20180727222540.GH173328@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
 <20180718232904.GJ128988@bhelgaas-glaptop.roam.corp.google.com>
 <65dd986d0b8b2ebe5132b365dabb2dbaaed9177f.camel@kernel.crashing.org>
 <20180727222540.GH173328@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-07-27 at 17:25 -0500, Bjorn Helgaas wrote:
> > As for the powerpc bits, I'm probably the one who wrote them, however,
> > I'm on vacation this week and right now, no bandwidth to context switch
> > all that back in :-) So give me a few days and/or ping me next week.
> 
> OK, here's a ping :)
> 
> Some powerpc cleanup would be ideal, but I'd like to fix the race for
> v4.19, so I'm fine with this patch as-is.  But I'd definitely want
> your ack before inserting the ugly #include path in the powerpc code.

Go for it. Looks like I got a last minute meeting in Austin next week
so i"ll have no time to look at any of this for a while.

Cheers,
Ben.

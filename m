Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8EDB62C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 19:48:51 +1000 (EST)
Message-ID: <1368611324.3659.0.camel@pasglop>
Subject: Re: [PATCH v1 00/22] powerpc/eeh: Enhance converting EEH dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 15 May 2013 19:48:44 +1000
In-Reply-To: <20130515084740.GA22813@shangw.(null)>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1368590264.31689.69.camel@pasglop> <20130515053049.GA28780@shangw.(null)>
 <1368597537.31689.70.camel@pasglop> <20130515084740.GA22813@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-15 at 16:47 +0800, Gavin Shan wrote:
> 
> Ok. Ben. Could you please point me the source code of the error
> injection framework? :-)
> I think you're not talking about userland utility "errinject".

It's minimal, it's just the stuff in lib/fault-inject which provides
a framework for exposing attributes for injecting errors along with the
tool in tools/testing/fault-injection, at least that's my understanding.

Or we can just add stuff under debugfs/powerpc, which is what I did
for wsp.

Cheers,
Ben.

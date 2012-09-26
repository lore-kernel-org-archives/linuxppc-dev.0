Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 064EA2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 08:47:21 +1000 (EST)
Message-ID: <1348699617.2443.12.camel@pasglop>
Subject: Re: /dev/port under powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Serge Teodori <teodori.serge@gmail.com>
Date: Thu, 27 Sep 2012 08:46:57 +1000
In-Reply-To: <CANUt7sogbn9ujj3rJHEgYwqEyWzYmEQtCDxOdCJH3yu8spdpxQ@mail.gmail.com>
References: <CANUt7sogbn9ujj3rJHEgYwqEyWzYmEQtCDxOdCJH3yu8spdpxQ@mail.gmail.com>
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

On Tue, 2012-09-25 at 14:27 +0200, Serge Teodori wrote:
> Hello,
> I am curently doing some cleanup, and noticed 'arch_has_dev_port()'
> could be omitted if 'arch/powerpc/configs/*' would be update with
> 'CONFIG_DEVPORT'. My question is, which ones have or have not an 'isa
> pci bridge'.

It's a runtime detection thing, CONFIG is not useful.

Cheers,
Ben.

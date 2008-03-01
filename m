Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A916FDDE05
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 19:11:00 +1100 (EST)
Message-ID: <47C90F83.3030700@s5r6.in-berlin.de>
Date: Sat, 01 Mar 2008 09:10:43 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/3] firewire: fw-ohci: shut up false compiler warning
	on PPC32
References: <tkrat.ac97915a5b51e35b@s5r6.in-berlin.de>	<tkrat.ee238048a5a50184@s5r6.in-berlin.de>
	<20080301141741.172013ba.sfr@canb.auug.org.au>
In-Reply-To: <20080301141741.172013ba.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Sat, 1 Mar 2008 02:50:44 +0100 (CET) Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> Wasn't there a macro somewhere for this?
> 
> Yes, uninitialized_var() in linux/compiler*.h

Right.  I actually did look into compiler.h and compiler-gcc.h but 
somehow didn't make it down into -gcc?.h.  Thanks,
-- 
Stefan Richter
-=====-==--- --== ----=
http://arcgraph.de/sr/

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4718DDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 23:17:50 +1000 (EST)
Subject: Re: PCI changes 2.6.26 => 2.6.28
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <49F0EB6A.40000@mlbassoc.com>
References: <49EDF333.4000200@mlbassoc.com>	<49EE2CD8.7010700@mlbassoc.com>
	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>
	<49EE306D.3000401@mlbassoc.com>	<49EE4729.3000100@mlbassoc.com>
	<612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>
	<46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>
	<49EE5021.4020703@mlbassoc.com>
	<306F293D-44CD-4238-ADA9-BB7436C7004C@kernel.crashing.org>
	<49EE5A80.4030209@mlbassoc.com>
	<B869D8DC-2A3B-4B53-8BFD-15D403CE20D4@kernel.crashing.org>
	<49F07A15.9010006@mlbassoc.com>
	<97DF2A19-563D-404A-AD3D-039D5989E489@kernel.crashing.org>
	<49F0EB6A.40000@mlbassoc.com>
Content-Type: text/plain
Date: Mon, 27 Apr 2009 23:17:32 +1000
Message-Id: <1240838253.7169.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-23 at 16:27 -0600, Gary Thomas wrote:

> I don't think any of this matters.  It turns out that even
> the 2.6.26 kernel fails on an identical board with a newer
> revision of the 8347 chip.  I'm sure that the problem is
> that the Coral-P fails when mapped to 0 (PCI relative).

There are macro that the PCI code uses to define the min address to
assign to devices but it's broken for us as it doesn't account
for the kind of remapping we do... I've been wanting to fix those
for some time but didn't get a chance yet, that would sort this out.

Ben.

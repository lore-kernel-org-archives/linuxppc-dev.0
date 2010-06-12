Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18D3C1007E5
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 20:45:54 +1000 (EST)
Subject: Re: Request review of device tree documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mitch Bradley <wmb@firmworks.com>
In-Reply-To: <4C13430B.5000907@firmworks.com>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Jun 2010 20:45:29 +1000
Message-ID: <1276339529.1962.184.camel@pasglop>
Mime-Version: 1.0
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Olof Johansson <olof@lixom.net>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-06-11 at 22:19 -1000, Mitch Bradley wrote:
> It seems that many of the differences at the CPU level can be determined 
> by looking at "coprocessor" registers.  For what purpose(s) do we need 
> to identify the core?  That will inform our choice of a core ID schema.

The primary thing I see would be architecture version compliance,
though this is better carried additionally via a binary field in
the header or a GPR at the entry point, to help the initial asm
code to setup the MMU etc... before getting into C code.

Cheers,
Ben.

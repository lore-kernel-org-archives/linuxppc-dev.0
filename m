Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5836B7DBC
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 18:20:00 +1000 (EST)
Message-ID: <4C13430B.5000907@firmworks.com>
Date: Fri, 11 Jun 2010 22:19:23 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Request review of device tree documentation
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
In-Reply-To: <AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Grant Likely wrote:
>
> I also changed the property in the cpu nodes from model to compatible
> so that the exact CPU version can be specified.  This isn't actually
> in any spec anywhere, but I need something to properly identify the
> different ARM cores.
>
> Mitch, I know you were working on a draft ARM binding a while ago,
> have you resurrected it at all?

As it turns out, today I re-began ARM OFW work in earnest, after a 
hiatus of something like 10 years.

I haven't thought much about a binding yet.  I'm still getting my head 
around the current state of the ARM art.

>   How do you think the core should be identified?
>   

When I was last working on ARM, few ARM devices had enough resources to 
run a general purpose OS.   To first approximation, StrongARM was the 
only game in town - so there wasn't much need to address the 
identification question.

It seems that many of the differences at the CPU level can be determined 
by looking at "coprocessor" registers.  For what purpose(s) do we need 
to identify the core?  That will inform our choice of a core ID schema.

> Cheers,
> g.
>
>
>   

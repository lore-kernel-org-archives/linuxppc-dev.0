Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BDFE568A44
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 20:08:29 +1100 (EST)
Date: Thu, 2 Feb 2006 01:08:27 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Message-ID: <20060202090827.GA12810@gate.ebshome.net>
References: <87wtgeeq8o.fsf@48ers.dk>
	<Pine.LNX.4.44.0602011851490.22854-100000@gate.crashing.org>
	<9305ca410602020009r4946d874qc52c2b27f715370f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9305ca410602020009r4946d874qc52c2b27f715370f@mail.gmail.com>
Cc: "Jenkins, Clive" <Clive.Jenkins@xerox.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2006 at 09:09:17AM +0100, Peter Korsgaard wrote:
> On 2/2/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> > > What is the preferred way of accessing non-PCI devices then? Direct
> > > pointer access?
> >
> > No direct pointer access is bad. On PPC You can use
> > in_be{8,16,32}/out_be{8,16,32}
> 
> What about arch independent drivers? Are there any generic approach
> for this or do you have to stick to ugly #ifdefs to decide between
> in_be32/inl ?

I'm curious, could you give an example of such arch independent 
driver?

-- 
Eugene

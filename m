Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8EC8DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 02:58:04 +1000 (EST)
Date: Thu, 19 Jul 2007 20:57:45 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 49/61] 8xx: Update device trees.
Message-ID: <20070719205745.57f9d5a0@localhost.localdomain>
In-Reply-To: <F8A0BE8F-8DBE-42DC-B3CD-02EB339A739E@kernel.crashing.org>
References: <20070718013604.GU15238@ld0162-tx32.am.freescale.net>
	<F8A0BE8F-8DBE-42DC-B3CD-02EB339A739E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

just my 2 cents.
[snip]
> 
> > +				fsl,cpm-brg = <1>;
> > +				fsl,cpm-command = <0090>;
> 
> Are these two documented?  Your patch queue is too
> long for me to check for myself.
> 
In fact, there were different approaches to describe CPM, and I am sure this is not the end.
These aren't documented, and I think we do not need that so far: I am pretty sure this will change
to something more comfortable as new similar ports will follow-up. Meanwhile, values are self-description
for anybody familiar with this SoC.

> > -	soc885@ff000000 {
> > +	bcsr@ff080000 {
> 
> Maybe use a more generic name, I have no idea what a
> "BCSR" is.
> 
IIRC, QE stuff, when first introduced, had bcsr bindings, that were discussed and agreed here.



-- 
Sincerely, Vitaly

Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE14467A70
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 08:04:44 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20050422215339.GA9488@gate.ebshome.net>
References: <OF6EA2D85F.3FCDDAC2-ON85256FEB.00750EFB@teal.com>
	<20050422215339.GA9488@gate.ebshome.net>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 17:04:44 -0500
Message-Id: <1114207484.27280.9.camel@jdub.homelinux.org>
Mime-Version: 1.0
Cc: Jeff.Fellin@rflelect.com, linuxppc-embedded@ozlabs.org
Subject: Re: Flash Statistics
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-04-22 at 14:53 -0700, Eugene Surovegin wrote:
> On Fri, Apr 22, 2005 at 05:19:17PM -0400, Jeff.Fellin@rflelect.com wrote:
> > 
> > I am looking for information in the kernel or elsewhere about flash usage
> > statistics. I'm interested in knowing how
> > many times a sector has been erased and written to. This doesn't have to be
> > for all time, since other tools
> > can erase and write the flash (U-boot), but just what the activity during
> > application processing. We use the
> > flash to store configuration files that are changeable and would like to
> > determine the expected lifetime
> > of the chips at use sites.
> > 
> > Any pointers to places where flash statistics are maintained or tools to
> > collect these statistics is
> > appreciated.
> 
> Flash datasheet must have this information.

They have information on the maximum number of writes per eraseblock,
yes.  But I think Jeff is looking for some statistic gathering tools he
can use to figure out how his application workload is effecting flash.
I doubt that is in any datasheets ;).

josh

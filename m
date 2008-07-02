Return-Path: <dcogley@uslinc.com>
Received: from mta11.charter.net (mta11.charter.net [216.33.127.80])
	by ozlabs.org (Postfix) with ESMTP id 88D8BDDF70
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 05:18:14 +1000 (EST)
Subject: Re: Updating glibc on SELF image
From: Dave Cogley <dcogley@uslinc.com>
To: Detlev Zundel <dzu@denx.de>
In-Reply-To: <m2hcb82ld1.fsf@ohwell.denx.de>
References: <1213824912.4450.20.camel@localhost.localdomain>
	<1213901149.4450.22.camel@localhost.localdomain>
	<m2hcb82ld1.fsf@ohwell.denx.de>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 12:18:15 -0700
Message-Id: <1215026295.3492.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you for the reply. I did not build the initial SELF image it was
provided to me from the board vendor. I used it as a starting point to
get something up and running on SELF. Can you point me to the
documentation on how to use the SELF RPM system?

Thanks,
Dave

On Wed, 2008-07-02 at 20:26 +0200, Detlev Zundel wrote:
> Hi Dave,
> 
> > Can someone provide a comprehensive guide for building SELF images from
> > scratch? More specifically how to install dependency libraries?
> 
> There is a mailing list specifically for ELDK and related questions[1].  
> 
> Apart from that, if you want to change SELF contents, you can either do
> it manually (as you started) or adjust the SELF spec file and rebuild
> the target RPM as documented in the DULG.
> 
> Apart from that I believe you somehow work with mismatching SELF and
> ELDK NFS installations.  The SELF rpm is built from the ELDK NFS
> installation, so it is simply not possible to have different versions of
> libraries between those two.
> 
> Cheers
>   Detlev
> 
> [1] http://lists.denx.de/mailman/listinfo/eldk
> 

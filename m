Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (vs166246.vserver.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86FCCDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 03:10:00 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v2] powerpc: Do not fail build if mkimage is not available
Date: Wed, 26 Dec 2007 17:08:51 +0100
References: <200712261655.56432.mb@bu3sch.de> <jezlvx1m00.fsf@sykes.suse.de>
In-Reply-To: <jezlvx1m00.fsf@sykes.suse.de>
MIME-Version: 1.0
Message-Id: <200712261708.51432.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Andrew Morton <akpm@osdl.org>, paulus@au.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 December 2007 17:03:43 Andreas Schwab wrote:
> Michael Buesch <mb@bu3sch.de> writes:
> 
> > +    set +e
> >      mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
> >  	$uboot_version -d "$vmz" "$ofile"
> > +    [ $? -eq 0 ] || exit 0
> > +    set -e
> 
> mkimage ... || exit 0

Could you PLEASE increase your verbosity?
Why is mkimage || exit 0 any better than my test?

-- 
Greetings Michael.

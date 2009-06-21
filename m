Return-Path: <hpa@zytor.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C442BB71C9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 17:26:08 +1000 (EST)
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0AE66DDDA0
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 17:26:06 +1000 (EST)
Message-ID: <4A3DDB27.2000500@zytor.com>
Date: Sun, 21 Jun 2009 00:03:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Frans Pop <elendil@planet.nl>
Subject: Re: Badness on the Warp
References: <20090620154824.72b5cd50@lappy.seanm.ca>
	<200906202256.46073.elendil@planet.nl>
In-Reply-To: <200906202256.46073.elendil@planet.nl>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frans Pop wrote:
> 
> The fact that your bisect ended at a merge essentially means that it is 
> invalid. As a merge does not introduce any actual change (unless it 
> includes changes to resolve conflicts), it normally cannot be the cause 
> of a regression.
> 

Sort of.  You can have a "bum merge" where code conflicts logically,
even if it isn't visible as a conflict in git.  Furthermore, of course,
you can have misresolved actual conflicts.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

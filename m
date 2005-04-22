Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EC22667A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 07:53:42 +1000 (EST)
Date: Fri, 22 Apr 2005 14:53:39 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff.Fellin@rflelect.com
Message-ID: <20050422215339.GA9488@gate.ebshome.net>
References: <OF6EA2D85F.3FCDDAC2-ON85256FEB.00750EFB@teal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF6EA2D85F.3FCDDAC2-ON85256FEB.00750EFB@teal.com>
Cc: linuxppc-embedded@ozlabs.org
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

On Fri, Apr 22, 2005 at 05:19:17PM -0400, Jeff.Fellin@rflelect.com wrote:
> 
> I am looking for information in the kernel or elsewhere about flash usage
> statistics. I'm interested in knowing how
> many times a sector has been erased and written to. This doesn't have to be
> for all time, since other tools
> can erase and write the flash (U-boot), but just what the activity during
> application processing. We use the
> flash to store configuration files that are changeable and would like to
> determine the expected lifetime
> of the chips at use sites.
> 
> Any pointers to places where flash statistics are maintained or tools to
> collect these statistics is
> appreciated.

Flash datasheet must have this information.

-- 
Eugene

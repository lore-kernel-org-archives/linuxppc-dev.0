Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B3F4F67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 07:06:16 +1000 (EST)
Date: Fri, 22 Apr 2005 14:06:11 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Message-ID: <20050422210610.GA9158@gate.ebshome.net>
References: <20050422194638.56637.qmail@web60507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050422194638.56637.qmail@web60507.mail.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Warm reboot on 826x targets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Apr 22, 2005 at 12:46:38PM -0700, Paul Gortmaker wrote:
> I should have asked what version of U-Boot you were using. 

This is not relevant, because Linux doesn't use this "checkstop" 
trick. It directly just jumps to U-Boot warm-reboot entry point.

-- 
Eugene

Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 28E666800B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 04:34:36 +1000 (EST)
Date: Tue, 9 Aug 2005 11:34:33 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050809183433.GA30956@gate.ebshome.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B85941B@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B85941B@ismail.innsys.innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 01:21:09PM -0500, Rune Torgersen wrote:
> 
> A proper fix would be for platfrom code to have a way to set time_nsec
> instead of having it set by a constant.

Or configure CLOCK_TICK_RATE in board/CPU specific fashion, e.g. like 
ARM does.

-- 
Eugene

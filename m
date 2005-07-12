Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 581D267A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jul 2005 04:45:17 +1000 (EST)
Date: Tue, 12 Jul 2005 11:45:15 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Guillaume Autran <gautran@mrv.com>
Message-ID: <20050712184514.GB3324@gate.ebshome.net>
References: <42D3D277.106@mrv.com> <20050712163921.GE25918@gate.ebshome.net>
	<42D40BF0.6040605@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42D40BF0.6040605@mrv.com>
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix destroy_context() race condition
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2005 at 02:29:04PM -0400, Guillaume Autran wrote:
> Eugene, destroy_context(..) can be called from other place outside of 
> the scheduler and switch_mm(...). See mmdrop(...) for example.
> In many of those cases, the task will run with preemption enable.

Ahh, OK, you're right. Maybe it's worth mentioning in the patch 
description :).

-- 
Eugene

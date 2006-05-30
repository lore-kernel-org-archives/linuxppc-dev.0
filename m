Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AAE03679FF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 18:06:24 +1000 (EST)
Date: Tue, 30 May 2006 01:06:21 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
Subject: Re: undefined symbols of modules
Message-ID: <20060530080621.GA16186@gate.ebshome.net>
References: <447BF82A.8000503@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <447BF82A.8000503@cs.fau.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, May 30, 2006 at 09:45:46AM +0200, Josef Angermeier wrote:
> Hello,
> 
> when i try to compile my kernel extension as modul, i get some undefined 
> references. But a look in System.map shows, that the relevant symbols 
> are defined in the main kernel. Why then those undefined references ?

Symbol must be exported to be available for modules, just being listed 
in System.map isn't enough.

Try adding EXPORT_SYMBOL(...) for those "undefined" references.

-- 
Eugene

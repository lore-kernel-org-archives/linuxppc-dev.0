Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BB25C67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 20:01:33 +1000 (EST)
Date: Tue, 5 Apr 2005 03:01:27 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Atit_Shah <Atit_Shah@Satyam.com>
Message-ID: <20050405100126.GB29168@gate.ebshome.net>
References: <A44765C986F8D411995B00B0D0795F4B3A828130@hhtnt002>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A44765C986F8D411995B00B0D0795F4B3A828130@hhtnt002>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problem with linux porting
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 05, 2005 at 02:24:01PM +0530, Atit_Shah wrote:
> We are having a problem with porting of Linux.

[snip]

> 4. Frequency
> 
>             Core:  346MHz
> 
>             CPM:   198MHz
> 
>             BUS:   99MHz
> 
>             Input: 66MHz

What does "Input" clock mean?

If it's a CLKIN, why is Bus clock not equal to it?

--
Eugene

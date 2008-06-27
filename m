Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BEEAFDDEFB
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 00:55:17 +1000 (EST)
Message-Id: <24590FB3-5A41-4CCC-964F-BE861ABA7FC0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18532.52894.698980.899308@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Please pull from 'powerpc-next' branch
Date: Fri, 27 Jun 2008 08:00:11 -0500
References: <Pine.LNX.4.64.0806260249300.14932@blarg.am.freescale.net>
	<98D3041A-F888-4991-9B10-CF4A9AD4A5BD@kernel.crashing.org>
	<18532.52894.698980.899308@cargo.ozlabs.ibm.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 27, 2008, at 6:27 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Paul, any update on when we might see some of the various patches
>> pulled into powerpc-next?
>
> This weekend assuming I get over this gastric flu-like lurgy that I
> have at the moment.

Uugh, that sucks.

>> I've got some work I'd like to see in .27 but it needs Michael's code
>> patching patches.
>
> I thought you had some concerns about patches 5/14 and 12/14 of his
> series?

5/14 needs some better comments but nothing that should hold up the  
acceptance and 12/14 or should be merged with 11/14 if he reposts the  
patch set.  But again, nothing to hold things up.

- k

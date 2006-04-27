Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 75E40679F5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 20:38:48 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Dan Malek <dan@embeddededge.com>
Subject: Re: Linux 2.6 sources for MPC852T processor
Date: Thu, 27 Apr 2006 12:41:20 +0200
References: <20060426025008.C8A7D773@resin02.mta.everyone.net>
	<200604261350.05295.david.jander@protonic.nl>
	<0606BE3C-7751-4E71-B724-FEFE2FF252C8@embeddededge.com>
In-Reply-To: <0606BE3C-7751-4E71-B724-FEFE2FF252C8@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604271241.20627.david.jander@protonic.nl>
Cc: chandrasekhar_n@math.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 27 April 2006 01:32, Dan Malek wrote:
> There is a horrible bug in the 8xx TLB miss handler that is in the
> 2.6.16
> sources.  I don't know when it appeared.  Enable the CPU6 Errata
> workaround to see if that solves the problem and please report back
> to me.  I'm working on a solution.

I received instructions from Marcelo to reverse two patches he sent me this 
morning, that did solve the problem. In fact those patches changed some 
TLB-related assembly code in head_8xx.S

Greetings,

-- 
David Jander

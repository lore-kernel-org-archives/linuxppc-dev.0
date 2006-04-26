Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD02F679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 10:26:57 +1000 (EST)
In-Reply-To: <200604261350.05295.david.jander@protonic.nl>
References: <20060426025008.C8A7D773@resin02.mta.everyone.net>
	<200604261350.05295.david.jander@protonic.nl>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0606BE3C-7751-4E71-B724-FEFE2FF252C8@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Linux 2.6 sources for MPC852T processor
Date: Wed, 26 Apr 2006 19:32:13 -0400
To: David Jander <david.jander@protonic.nl>
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


On Apr 26, 2006, at 7:50 AM, David Jander wrote:

> Yes, MPC852T is supported, although I might add that I have been  
> using 2.6.14
> and 2.6.15 sucessfully with our own MPC852T-based board, but 2.6.16  
> did not
> boot and as of today I don't know why, or whether this is an issue  
> at all
> with boards other than ours.

There is a horrible bug in the 8xx TLB miss handler that is in the  
2.6.16
sources.  I don't know when it appeared.  Enable the CPU6 Errata
workaround to see if that solves the problem and please report back
to me.  I'm working on a solution.

Thanks.

	-- Dan

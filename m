Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 5488367C2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 09:29:54 +1100 (EST)
To: mporter@kernel.crashing.org
Subject: Re: [PATCH v2 -- fixed changelog] [POWERPC] Add support for Rev. B of
	PowerPC 440SPe
References: <adalkmf44eu.fsf@cisco.com> <adaac2v2d2g.fsf@cisco.com>
	<20061114090102.GA16520@gate.ebshome.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Nov 2006 14:29:51 -0800
In-Reply-To: <20061114090102.GA16520@gate.ebshome.net> (Eugene Surovegin's
	message of "Tue, 14 Nov 2006 01:01:02 -0800")
Message-ID: <adapsbowdgg.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > Can we get rid of this switch as well?
 > 
 > There are other places like this in the patch but I think you got my 
 > idea :).

Makes sense -- I'll rework the patch to cut down on the code
duplication (which is already there in my code that went upstream).  I
think there have to be switches (or equivalently, look-up tables)
since there's no regularity in where the DCRs/SDRs for the different
PCIe ports are.

 - R.

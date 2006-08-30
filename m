Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93A8767B5E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 03:13:55 +1000 (EST)
Date: Wed, 30 Aug 2006 12:25:28 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: akhilesh@innomedia.soft.net
Subject: Re: Driver for OCP Driver for PPC405
Message-ID: <20060830172528.GA25897@gate.crashing.org>
References: <1417.59.165.59.34.1156954325.squirrel@59.165.59.34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417.59.165.59.34.1156954325.squirrel@59.165.59.34>
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

On Wed, Aug 30, 2006 at 09:42:05PM +0530, akhilesh@innomedia.soft.net wrote:
> Hi,
> 
> I need a OCP IDE driver for IBM PPC405 redwood6 platform for 2.6 kernel.
> Any pointer for same or similar driver would be highly appreciated.

List archives are your friend.

http://ozlabs.org/pipermail/linuxppc-embedded/2005-February/016715.html

Read the whole thread...there's a patch that applies to linuxppc-2.5 (and
the location to rsync that old tree) in a later mail. It didn't go
upstream because the author didn't clean up some minor things needed
for upstream inclusion.

-Matt

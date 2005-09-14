Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31D876826F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 22:46:01 +1000 (EST)
Message-ID: <43281B7D.5000106@pobox.com>
Date: Wed, 14 Sep 2005 08:45:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <20050831045847.GA17017@gate.ebshome.net>
	<20050831050048.GB17017@gate.ebshome.net>
In-Reply-To: <20050831050048.GB17017@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] New PowerPC 4xx on-chip ethernet controller driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> Remove old PPC4xx EMAC driver
> 
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

Please post a diff, along with a description of the changes.

One huge patch to "remove emac driver" and another huge patch to "add 
emac driver" is quite silly.

	Jeff

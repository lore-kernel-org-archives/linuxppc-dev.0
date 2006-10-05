Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58B1067CE3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 21:30:24 +1000 (EST)
Message-ID: <4524ECC6.2060201@garzik.org>
Date: Thu, 05 Oct 2006 07:30:14 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehea bug fix (port state notification, default
	queue sizes)
References: <200609281244.40887.ossthema@de.ibm.com>
In-Reply-To: <200609281244.40887.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

which patch is to be applied first?

You failed to include an order, as described by 
http://linux.yyz.us/patch-format.html and Documentation/SubmittingPatches.

Also, stuff like "hi Jeff" and "Thanks, Jan-Bernd" must be hand-edited 
out before patch application.  All comments not intended to be DIRECTLY 
copied into the kernel changeset description should follow the "---" 
separator.

	Jeff

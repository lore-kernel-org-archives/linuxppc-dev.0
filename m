Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53B3E67A3E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 07:50:37 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FZEN7-0008HD-SH
	for linuxppc-dev@ozlabs.org; Thu, 27 Apr 2006 23:50:01 +0200
Received: from p50814d44.dip.t-dialin.net ([80.129.77.68])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 23:50:01 +0200
Received: from info by p50814d44.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 23:50:01 +0200
To: linuxppc-dev@ozlabs.org
From: Heiko J Schick <info@schihei.de>
Subject: Re: [PATCH 06/16] ehca: common include files
Date: Thu, 27 Apr 2006 23:31:41 +0200
Message-ID: <e2rd7t$94v$1@sea.gmane.org>
References: <4450A183.6030405@de.ibm.com>
	<200604271319.06844.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: news <news@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2006-04-27 13:19:06 +0200, Arnd Bergmann <arnd.bergmann@de.ibm.com> said:

> Well, you should also remove this for submission, I guess ;-)

Yeah, I've planed to remove this lines when 2.6.17 official came out.
It is still included because we don't want to introduce unnecessary
dependencies.

I will remove it for the next patchset.

Regards,
	Heiko

Return-Path: <sean.maclennan@pikatech.com>
Received: from fusion.kanatek.com (fusion.kanatek.com [207.107.229.150])
	by ozlabs.org (Postfix) with ESMTP id BBA32DDF4A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 05:08:02 +1100 (EST)
Received: from [207.107.229.5] (helo=pks00005.kanatek.com)
	by fusion.kanatek.com with esmtp (Exim 4.66)
	(envelope-from <sean.maclennan@pikatech.com>) id 1JD1Nb-00059x-Cy
	for linuxppc-dev@ozlabs.org; Thu, 10 Jan 2008 12:39:47 -0500
Message-ID: <47866614.3010203@pikatech.com>
Date: Thu, 10 Jan 2008 13:38:12 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
Subject: ibm4xx_quiesce_eth?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What exactly does this function do?

    /* Quiesce the MAL and EMAC(s) since PIBS/OpenBIOS don't
     * do this for us
     */

On the taco, with the 440EP, it doesn't seem to make any difference if I 
call this or not. Since I am using u-boot, is it not needed?


Cheers,
   Sean

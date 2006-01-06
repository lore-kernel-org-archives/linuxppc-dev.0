Return-Path: <KokHow.Teh@marconi.com>
Received: from smtpoutuk01.marconi.com (smtpoutuk01.marconi.com
	[128.87.251.112]) by ozlabs.org (Postfix) with ESMTP id 798366893D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 20:09:48 +1100 (EST)
Received: from cvdgwy01.uk.marconicomms.com (cvis26.uk.marconicomms.com
	[128.87.251.109])
	by smtpoutuk01.marconi.com (8.12.11/8.12.11) with ESMTP id
	k0699eqg023640
	for <linuxppc-embedded@ozlabs.org>; Fri, 6 Jan 2006 09:09:40 GMT
	(envelope-from KokHow.Teh@marconi.com)
To: linuxppc-embedded@ozlabs.org
From: "KokHow Teh" <KokHow.Teh@marconi.com>
Date: Fri, 6 Jan 2006 17:09:35 +0800
Message-ID: <OFF860A6FA.D61DCEB9-ON482570EE.0031F142@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: Re: [PM-SPAM] Help need: Porting Linux to PQ2FADS_ZU board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>bootargs=root=/dev/nfs rw nfsroot=172.17.248.253:/opt/eldk3/ppc_6xx
ip=172.17.24
>8.244:172.17.248.253:172.17.248.253:255.255.255.0:pq2fads::off

add console=/dev/ttyS0,115200n8 and see if it works?

Return-Path: <albertcc@tw.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C914567BE7
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 17:10:36 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB66AXKj019944
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 01:10:33 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB66AXHs458954
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Dec 2006 23:10:33 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB66AWYb027338
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Dec 2006 23:10:33 -0700
Message-ID: <45765EC7.2000908@tw.ibm.com>
Date: Wed, 06 Dec 2006 14:10:15 +0800
From: Albert Lee <albertcc@tw.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Oops in pata_pdc2027x
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
In-Reply-To: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: albertl@mail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi all,
> 
> I get an oops during initialisation of the pata_pdc2027x module on a
> POWER 285 machine.  This is on a very recent Linus kernel tree
> (ff51a98799931256b555446b2f5675db08de6229) with Paulus' powerpc tree
> (that has now been merged). The oops looks like this:
> 

Hi Stephen,

Where could I download the patched kernel source? There are two
POWER5 9110-51A boxes here. Maybe I could try to reproduce the problem
on these boxes.

--
albert

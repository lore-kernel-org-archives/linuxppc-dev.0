Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C525A67AA0
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 00:49:57 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673066CF774@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673066CF774@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <259AC268-6D75-4EEF-962E-BDBC6D76BC02@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Fri, 2 Jun 2006 09:50:00 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: Alexandre.Bounine@tundra.com, Liu Dave-r63238 <DaveLiu@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 2, 2006, at 3:20 AM, Zang Roy-r61911 wrote:

>
>> How much RAM do you have ? Maybe you are running out of
>> virtual space ?
>>
>> Ben.
>>
>>
>
> 512MBytes

If I understand things, there is a 16M region for PCI config space.   
You could look at just doing the ioremap for each chunk when its  
needed via the low level calls.

- kumar

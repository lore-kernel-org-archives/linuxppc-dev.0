Return-Path: <haupt.andre@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8A98CDDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 19:12:00 +1100 (EST)
Message-ID: <45B7146F.90402@gmx.de>
Date: Wed, 24 Jan 2007 09:10:23 +0100
From: Andre Haupt <haupt.andre@gmx.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: nfs mounting problem
References: <OFEEBC95A7.C19B5826-ON6525726C.004962C8-6525726C.00497146@lntemsys.com>
	<45B61459.1030507@gmx.de> <45B62AA7.4020306@freescale.com>
In-Reply-To: <45B62AA7.4020306@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org,
	Manjunath AM <Manjunath.AM@Lntemsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Andre Haupt wrote:
>> Also what seems a bit odd to me is that your dmesg shows no rootpath
>>
>>  IP-Config: Complete:
>>       device=eth1, addr=192.168.178.234, mask=255.255.255.0, 
>> gw=192.168.178.47,
>>      host=cashel, domain=, nis-domain=(none),
>>      bootserver=192.168.178.110, rootserver=192.168.178.110, rootpath=
>>
>> On my system the complete root path is printed here.
>
> I don't think I've ever seen the root path printed there (with nfsroot 
> otherwise working), so I don't think that's the problem...  From 
> looking at the code, it seems that the root path received from BOOTP 
> is stored in a different variable than the path from the nfsroot boot 
> option, and it's the former that gets printed there.
Ahh, ok. I am using BOOTP, so this has nothing to do with Manjunaths 
problem. Thanks for clarification.

Best,

Andre

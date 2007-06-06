Return-Path: <adetsch@br.ibm.com>
Received: from igw1.br.ibm.com (igw1.br.ibm.com [32.104.18.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw1.br.ibm.com", Issuer "SMTP Support" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 55246DDED1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 00:43:48 +1000 (EST)
Received: from mailhub1.br.ibm.com (mailhub1 [9.18.232.109])
	by igw1.br.ibm.com (Postfix) with ESMTP id EEE7D148320
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 11:30:52 -0300 (BRT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.18.232.47])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l56Eh3ji487552
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 11:43:04 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l56Eftsv016062
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jun 2007 11:41:56 -0300
Message-ID: <4666C7A9.1050409@br.ibm.com>
Date: Wed, 06 Jun 2007 11:41:45 -0300
From: =?ISO-8859-1?Q?Andr=E9_Detsch?= <adetsch@br.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [patch 01/18] Cell: Add spu shutdown method
References: <20070606024407.786638029@am.sony.com> >
	<46662303.1040606@am.sony.com>
	<1181102914.5536.22.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1181102914.5536.22.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2007-06-05 at 19:59 -0700, Geoff Levand wrote:
>> Add a shutdown method to spu_sysdev_class to allow proper spu resource
>> cleanup on system shutdown.  This is needed to support kexec on the PS3
>> platform.
>>
>> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> ---
>>  arch/powerpc/platforms/cell/spu_base.c |   12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> André, does this interact with your kexec work at all?

No. My cell kexec patch is actually crash-specific, activated under 
default_machine_crash_shutdown. Geoff's ps3 kexec patches do not seem to 
affect this code path.

--
Andre Detsch

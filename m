Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34EC0DDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 07:39:28 +1000 (EST)
Message-ID: <48640C69.8000507@zytor.com>
Date: Thu, 26 Jun 2008 14:38:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: monstr@seznam.cz
Subject: Re: [PATCH 30/60] microblaze_v4: support for a.out
References: <1214483429-32360-22-git-send-email-monstr@seznam.cz>	<1214483429-32360-23-git-send-email-monstr@seznam.cz>	<1214483429-32360-24-git-send-email-monstr@seznam.cz>	<1214483429-32360-25-git-send-email-monstr@seznam.cz>	<1214483429-32360-26-git-send-email-monstr@seznam.cz>	<1214483429-32360-27-git-send-email-monstr@seznam.cz>	<1214483429-32360-28-git-send-email-monstr@seznam.cz>	<1214483429-32360-29-git-send-email-monstr@seznam.cz>	<1214483429-32360-30-git-send-email-monstr@seznam.cz>	<1214483429-32360-31-git-send-email-monstr@seznam.cz>	<20080626143713.GE30954@cs181140183.pp.htv.fi>	<4863ECCE.2000407@seznam.cz>
	<4863ED98.50608@zytor.com> <48640A88.8070402@seznam.cz>
In-Reply-To: <48640A88.8070402@seznam.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, john.williams@petalogix.com,
	drepper@redhat.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michal Simek wrote:
>> Michal Simek wrote:
>>> I expect it but I haven't information about. I'll check it.
>> I'm assuming Microblaze doesn't actually add a.out support, does it?
> 
> I think that any support were there but I assume that no one use it.

Most other new architectures don't bother, hence the question.

	-hpa

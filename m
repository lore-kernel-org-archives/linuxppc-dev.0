Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11727B7BBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Oct 2009 03:30:30 +1100 (EST)
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091016160125.GC11838@loki.buserror.net>
Date: Fri, 16 Oct 2009 11:30:22 -0500
Message-Id: <5F7F54D6-0487-433C-B58B-E6FA3F816CDB@kernel.crashing.org>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
	<20091014152722.GA17867@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AE72C@alice.at.omicron.at>
	<20091015162728.GB3730@loki.buserror.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E2AE800@alice.at.omicron.at>
	<20091016160125.GC11838@loki.buserror.net>
To: Richard Cochran <richard.cochran@omicron.at>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 16, 2009, at 11:01 AM, Scott Wood wrote:

>>
>> I have the LITE5200B, MPC8313-ERDB, MPC8572DS, and the P2020DS in
>> house, and it is really the same, sad story with each of
>> them. Wouldn't it be grand if the development boards would boot "out
>> of the box" when compiling the most recent kernel with default  
>> config?
>
> That's what the group I'm in tries to make sure happens (for the
> mpc8xxx/qoriq chips) -- but we're outnumbered by the BSP developers,  
> so some
> BSP features tend to be missing.  Basic board support should be there,
> though.
>
> I just booted 2.6.32-rc4 straight from Linus on an mpc8572ds  
> yesterday.
> I've booted various upstream kernels on mpc8313erdb (typically an  
> older rev,
> though).

Also, if they don't boot out of the box report an issue on this list.   
That is part of the community testing aspect of open source.

- k

Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1CCADDE32
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 03:04:36 +1000 (EST)
In-Reply-To: <2A35E795-6F01-4A14-BE23-B46F110DBD60@kernel.crashing.org>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
	<E1IAvVm-0005yQ-LO@jdl.com>
	<46464F84-5040-4F37-B854-94378C9802AD@kernel.crashing.org>
	<2A35E795-6F01-4A14-BE23-B46F110DBD60@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <68F1D34D-52BF-4D20-99BD-6E16A32C6A79@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add StorCenter DTS first draft. 
Date: Thu, 19 Jul 2007 19:03:58 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>     compatible = "fsl,mpc8241-i2c", "fsl-i2c";
>>
>> That looks good yes.  Or if the kernel side code for
>> recognising fsl,mpc8241-i2c gets merged in time, you
>> can leave out fsl-i2c from your device tree completely.
>
> Hmm, there are really only two fsl,i2c controllers.  The one we  
> call fsl-i2c, and the cpm-i2c controller.
>
> So I'd prefer we don't use fsl,mpc8241-i2c.  I'd suggest fsl,ppc- 
> i2c or something like that.

The actual name doesn't matter much, as long as it is "unique
enough"; a name that matches a name already in use in real life
is preferred; normally the name is just the name of the first
device that had this specific programming interface.

But choose whatever you want.  It is a good idea to always
put the exact name of the specific device in there, too, btw,
so you'd end up with "fsl,mpc8241-i2c", "fsl,ppc-i2c" if your
suggestion is accepted.


Segher

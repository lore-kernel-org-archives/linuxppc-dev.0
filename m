Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDDD267B54
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 23:22:59 +1000 (EST)
In-Reply-To: <001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
References: <001301c6abf8$73d780e0$99dfdfdf@bakuhatsu.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <678C8D4E-C3AC-4F79-BFF2-5BF424682D04@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: AltiVec in the kernel
Date: Thu, 20 Jul 2006 08:23:12 -0500
To: matt@genesi-usa.com
Cc: 'Paul Mackerras' <paulus@samba.org>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 20, 2006, at 7:31 AM, Matt Sealey wrote:

>
>
>> But perhaps, in principle, couldn't one run four independent
>> streams in parallel?  Thus, for example, on an SSL-enabled
>> web server, one could service multiple encryption/decryption
>> threads at once.
>>
>> In practice, I don't beleive the infrastructure for that kind
>> of parallelism is in place. I'm struggling to find a reason
>> to develop that kind of infrastructure. Mumble something about Cell.
>
> If not AltiVec there is potential to use some features which come
> with AltiVec like the data stream functionality. Or even the standard
> PPC cache control stuff would work.
>
> What's the case in the kernel for the memcpy functions etc., are
> they optimized for doing things like longword copies rather than
> byte-per-byte etc.? We found glibc sucked for that.

Matt, can I ask what exactly you are trying to accomplish?  There is  
a lot of work put into the kernel to ensure things are optimized.   
I'd say far more so than gets put into user space.

- k

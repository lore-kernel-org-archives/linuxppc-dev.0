Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C324DDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Mar 2007 01:30:55 +1100 (EST)
In-Reply-To: <1173129745.24846.50.camel@saruman.qstreams.net>
References: <1173129745.24846.50.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E32AE64-2BE2-4B74-8AEC-4A42AF888010@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Reset cause API
Date: Thu, 8 Mar 2007 08:29:57 -0600
To: bwarren@qstreams.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 5, 2007, at 3:22 PM, Ben Warren wrote:

> Hello,
>
> Is there an API call, either Linux or PowerPC-specific, for  
> determining
> the cause of the last reset?  I can certainly read the RSR myself, but
> why bother if the information's available elsewhere.

There isnt anything like this since we don't have any consistent way  
of maintaining information across a reset.

Something like kexec could possibly do something.

- k

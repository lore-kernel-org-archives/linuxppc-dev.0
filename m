Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70DF9DDF90
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 04:43:37 +1000 (EST)
Message-Id: <42E5BD30-8DF6-4911-B331-558BAB96968B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: dhlii@dlasys.net
In-Reply-To: <4A0457BC.3040408@dlasys.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: device trees.
Date: Fri, 8 May 2009 13:43:20 -0500
References: <4A0457BC.3040408@dlasys.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

you can look at the source to SLOF or u-boot to see cases of building  
nodes on the fly.

- k

On May 8, 2009, at 11:03 AM, David H. Lynch Jr. wrote:

>    Is there an example somewhere that shows building a device tree on
> the fly ?
>
>    As our products move forward it becomes increasingly clear that
> static configurations are not going to work.
>
>
>
>
> -- 
> Dave Lynch 					  	    DLA Systems
> Software Development:  				         Embedded Linux
> 717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
> fax: 1.253.369.9244 			           Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies  
> too numerous to list.
>
> "Any intelligent fool can make things bigger and more complex... It  
> takes a touch of genius - and a lot of courage to move in the  
> opposite direction."
> Albert Einstein
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

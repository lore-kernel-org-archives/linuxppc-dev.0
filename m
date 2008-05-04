Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AED3DDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 10:26:21 +1000 (EST)
Message-ID: <481E4655.7040000@zytor.com>
Date: Sun, 04 May 2008 16:27:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to link a .o with all modules
References: <6C8AB345-2DA0-460D-B7C8-262463247DDE@kernel.crashing.org>
In-Reply-To: <6C8AB345-2DA0-460D-B7C8-262463247DDE@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>, sam@ravnborg.org,
	lkml List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Sam,
> 
> We have a case in powerpc in which we want to link some library routines 
> with all module objects.  The routines are intended for handling 
> out-of-line function call register save/restore so having them as 
> EXPORT_SYMBOL() is counter productive (we do also need to link the same 
> "library" code into the kernel).
> 

Why is having them as an EXPORT_SYMBOL() counterproductive?  It sounds 
like *exactly* what you need -- and then having the kernel provide the 
same code to modules, instead of replication...?

	-hpa

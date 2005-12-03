Return-Path: <otavio@debian.org>
Received: from covilha.procergs.com.br (covilha.procergs.com.br
	[200.198.128.244]) by ozlabs.org (Postfix) with ESMTP id 4803D68864
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 08:30:25 +1100 (EST)
From: Otavio Salvador <otavio@debian.org>
To: linuxppc-dev@ozlabs.org
References: <11336368261610-git-send-email-otavio@debian.org>
	<20051203212402.GA2821@gate.ebshome.net>
Date: Sat, 03 Dec 2005 19:31:17 -0200
In-Reply-To: <20051203212402.GA2821@gate.ebshome.net> (Eugene Surovegin's
	message of "Sat, 3 Dec 2005 13:24:02 -0800")
Message-ID: <87lkz127h6.fsf@nurf.casa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@osdl.org
Subject: Re: [PATCH] include/asm-ppc/btext.h: add prototype of btext_init
	function.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eugene Surovegin <ebs@ebshome.net> writes:

...
>> +extern void __init btext_init(boot_infos_t *bi);
...
>
> "__init" should be placed between closing brace and semicolon. For 
> more info, see include/linux/init.h

Ok. Thanks, I'll resend the patch.

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."

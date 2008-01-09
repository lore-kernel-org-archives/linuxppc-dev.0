Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 94860DDF16
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 15:39:52 +1100 (EST)
Message-ID: <47845009.8070106@windriver.com>
Date: Tue, 08 Jan 2008 23:39:37 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/7] sbc8560: add support for Wind River SBC8560 in
	arch/powerpc
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>	<11997159331132-git-send-email-paul.gortmaker@windriver.com>	<11997159342128-git-send-email-paul.gortmaker@windriver.com>	<11997159352727-git-send-email-paul.gortmaker@windriver.com>
	<20080108113219.860ac365.sfr@canb.auug.org.au>
In-Reply-To: <20080108113219.860ac365.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Paul,
>
> On Mon,  7 Jan 2008 09:25:28 -0500 Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>   
>

[...]

>> +static const struct cpm_pin sbc8560_pins[] = {
>>     
>
> Of course, these could be __initdata (but not const as well).  Sorry
> about not mentioning this last time and it is a trivial change that
> should not stop this stuff going in.
>   

No problem.  I think you will find all these issues are applicable to
the mpc8560mds support that I based things off too.  I'd rather do
a single patch for both boards to deal with these, rather than respin
the sbc8560 patches again and leave the mpc8560mds behind.
Assuming everyone else is OK with this approach.

Thanks,
Paul.

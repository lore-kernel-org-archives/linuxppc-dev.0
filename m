Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9FB9DE034
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 09:39:19 +1000 (EST)
Message-ID: <48C9ABFF.1080507@emcraft.com>
Date: Fri, 12 Sep 2008 03:38:39 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
	<1715327082.20080911221507@emcraft.com>
	<20080911200906.GD26684@yoda.jdub.homelinux.org>
In-Reply-To: <20080911200906.GD26684@yoda.jdub.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, prodyut hazarika <prodyuth@gmail.com>, dzu@denx.de,
	wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Josh,

Josh Boyer wrote:
> Ok, but not everyone does.  And I think setting the page size to this
> should be harder, maybe even dependent upon CONFIG_BROKEN.
>   

Well, we are violating ELF standard here... CONFIG_BROKEN seems to be 
adequate for me.

> I need to look over the patch a bit more, but some of the comments you've
> already gotten seem valid.
>   

I'll address them and post updated patch in a few days.

Regards, Ilya.

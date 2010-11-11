Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9E0AAB712C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 23:19:00 +1100 (EST)
To: Ilya Yanok <yanok@emcraft.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [REPOST][PATCH] mpc8308: fix USB DR controller initialization
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1288137756-3389-1-git-send-email-yanok@emcraft.com>
References: <1282906641-25351-1-git-send-email-yanok@emcraft.com>
	<1288137756-3389-1-git-send-email-yanok@emcraft.com>
Date: Thu, 11 Nov 2010 13:18:55 +0100
Message-Id: <20101111121855.C35751522C0@gemini.denx.de>
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Ilya Yanok,

In message <1288137756-3389-1-git-send-email-yanok@emcraft.com> you wrote:
> MPC8308 has ULPI pin muxing settings in SICRH register, bits 17-18
> which is different from both MPC8313 and MPC8315.
> Also MPC8308 doesn't have REFSEL, UTMI_PHY_EN and OTG_PORT fields
> in the USB DR controller CONTROL register.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

Tested-by: Wolfgang Denk <wd@denx.de>
Acked-by: Wolfgang Denk <wd@denx.de>

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you think the problem is bad now, just wait until we've solved it.
                                                        Epstein's Law

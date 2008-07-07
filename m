Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 53D9BDDE1A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:04:42 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so965604ugf.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 11:04:40 -0700 (PDT)
Message-ID: <48725ABA.3070706@genesi-usa.com>
Date: Mon, 07 Jul 2008 19:04:42 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: e600 core power management
References: <48720279.6010904@genesi-usa.com>
In-Reply-To: <48720279.6010904@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think I'll reiterate here as it got lost in my rambling, that I am wondering
if NAP is enabled *by default* and if not, why not on processors that don't
doze? (powersave-nap is 0 here)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Matt Sealey wrote:
> Hi guys,
> 
> Quick question, am I right (and looking at idle_6xx.S, I think I am) in 
> thinking that
> during the idle process, by default, an e600 core such as the 7448 or 
> MPC8610 will
> automatically transition to a NAP state, thus being as low power as 
> possible?

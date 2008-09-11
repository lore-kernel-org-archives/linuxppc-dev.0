Return-Path: <prodyuth@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.236])
	by ozlabs.org (Postfix) with ESMTP id 82C25DE0E2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 04:53:52 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id a16so746663qbd.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 11:53:50 -0700 (PDT)
Message-ID: <49c0ff980809111153m508f8c90x8db61f2bd287c07@mail.gmail.com>
Date: Thu, 11 Sep 2008 11:53:49 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Ilya Yanok" <yanok@emcraft.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
In-Reply-To: <48C96349.1040903@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
	<48C96349.1040903@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> Any comments on the issues mentioned in introductory message?
>

I am reviewing the changes more thoroughly. I will give additional
comments within the next 2-3 days.
I am working on putting similar support for 405EX (Kilauea board), but
having some issues.
I will post the patch after I am done with it.

Also, it would be great if you could point me what changes are
necessary to recompile the binutils.
I would like to test the 256KB changes on my Canyonlands board. I have
got 16KB/64KB working.

Regards,
Prodyut Hazarika

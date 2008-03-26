Return-Path: <neko@genesi-usa.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by ozlabs.org (Postfix) with ESMTP id 32CDADE3DC
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 03:48:54 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so3642820wxd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:48:53 -0700 (PDT)
Message-ID: <47EA7E72.3010502@genesi-usa.com>
Date: Wed, 26 Mar 2008 16:48:50 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Missing patch for MPC5200B register definitions?
References: <47EA7687.5000102@genesi-usa.com>
In-Reply-To: <47EA7687.5000102@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oh yes, I forgot.. also, the new MPC5121E stuff includes a lot of unions and
defines to make using both PSC formats easier.

Since the MPC5200 and MPC5200B PSC structures are different (CCR size), can the
original suggestion (in that thread) to support both with a union and some
defines to make supporting both CCR sizes, be implemented, or do we still think
that MPC5200 (not B) is not worth supporting?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Matt Sealey wrote:
> I've just been looking into the MPC5200B AC97 driver breakage with the
> latest Git kernel, and found the following patch;
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035952.html
> 
> Is not in the latest tree. As such anything which uses the new MPC5200B
> registers (especially important on AC97 and probably not used otherwise)
> has not or was not applied.
> 
> Since the latest kernel source from git actually includes the MPC5121E
> differences, I assume this is a regression?
> 
> How do we go about fixing this?
> 

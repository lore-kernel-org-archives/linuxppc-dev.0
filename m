Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [195.145.229.155])
	by ozlabs.org (Postfix) with ESMTP id 8D7A5DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 20:59:26 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/5] rapidio: adding memory mapping IO support and misc
	fixes
Date: Fri, 8 May 2009 12:28:10 +0200
References: <1241705447.19689.114.camel@demuxf9c>
	<AF270294-0B90-4935-9D4A-F17EB7811CE2@kernel.crashing.org>
	<1241777196.16400.25.camel@demuxf9c>
In-Reply-To: <1241777196.16400.25.camel@demuxf9c>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905081228.10955.g.jaeger@sysgo.com>
Cc: Jan Neskudla <jan.neskudla.ext@nsn.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jan,

On Friday 08 May 2009 12:06:35 Jan Neskudla wrote:
[SNIPSNAP]
> Important CONFIG options are: 
> PPC_86xx=y
> HPC8641_HPCN=y

you're using a e500 board (EP8548A), but the options above
will be used when building a kernel for a e600 machine (MPC8641).
Are you sure that is okay?

- Gerhard
-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                                Embedding Innovations
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 

Return-Path: <sam@ravnborg.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 73DD8B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 08:01:51 +1000 (EST)
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id ED353DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 08:01:50 +1000 (EST)
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id D33E080CA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 23:31:39 +0200 (CEST)
Date: Thu, 23 Jul 2009 23:31:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] powerpc: minor Makefile simplification through use of
	cc-ifversion
Message-ID: <20090723213132.GA9514@merkur.ravnborg.org>
References: <200907232057.19942.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200907232057.19942.elendil@planet.nl>
Cc: linuxppc-dev@ozlabs.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 23, 2009 at 08:57:18PM +0200, Frans Pop wrote:
> Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

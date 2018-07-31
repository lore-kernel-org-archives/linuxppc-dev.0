Return-Path: <srs0=0r9g=kp=russell.cc=ruscur@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fhVx475xzF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 13:19:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41fhVx1qrFz8x5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 13:19:21 +1000 (AEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41fhVv1WZ6z9ryn
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 13:19:17 +1000 (AEST)
Message-ID: <f3d01006332808878d63786f4537d46bc85ff94f.camel@russell.cc>
Subject: Re: [PATCH] powerpc: Add a checkpatch wrapper with our preferred
 settings
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Tue, 31 Jul 2018 13:19:10 +1000
In-Reply-To: <20180724140346.10575-1-mpe@ellerman.id.au>
References: <20180724140346.10575-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-25 at 00:03 +1000, Michael Ellerman wrote:
> This makes it easy to run checkpatch with settings that we have
> agreed
> on (bwhahahahah).
> 
> Usage is eg:
> 
>   $ ./arch/powerpc/tools/checkpatch.sh -g origin/master..
> 
> To check all commits since origin/master.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Russell Currey <ruscur@russell.cc>

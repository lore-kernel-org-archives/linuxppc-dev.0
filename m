Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxwCk5D1rzDqZ0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 19:57:54 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u18so1382209pgo.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 02:57:54 -0700 (PDT)
Date: Wed, 20 Sep 2017 17:57:47 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 0/3] powerpc: memcmp() optimization
Message-ID: <20170920095747.GB3387@simonLocalRHEL7.x64>
References: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
 <531bcb91-c5ef-278b-ab6f-a2b8f246a26a@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <531bcb91-c5ef-278b-ab6f-a2b8f246a26a@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chris,
On Tue, Sep 19, 2017 at 02:21:33PM +0200, Christophe LEROY wrote:
> Hi
> 
> Could you in the email/patch subject and in the commit texts write
> powerpc/64 instead of powerpc as it doesn't apply to powerpc/32
> 
> Christophe
> 
Sure. I will update in v2.

BR,
- Simon

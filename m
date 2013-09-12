Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C944F2C035C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 18:14:03 +1000 (EST)
In-Reply-To: <201309111550.r8BFoS4G015798@localhost.localdomain>
References: <201309111550.r8BFoS4G015798@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc 8xx: Reverting commit
 e0908085fc2391c85b85fb814ae1df377c8e0dcb which has become useless
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OFCD99DF58.8FB3071C-ONC1257BE4.002D04C9-C1257BE4.002D38F4@transmode.se>
Date: Thu, 12 Sep 2013 10:13:56 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2013/09/11 17:50:28:

> From: Christophe Leroy <christophe.leroy@c-s.fr>
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras 
<paulus@samba.org>, 
> Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Joakim 
Tjernlund <joakim.tjernlund@transmode.se>
> Date: 2013/09/11 18:43
> Subject: [PATCH] powerpc 8xx: Reverting commit 
e0908085fc2391c85b85fb814ae1df377c8e0dcb which has become useless
> 
> The commit e0908085fc2391c85b85fb814ae1df377c8e0dcb is not needed 
anymore.
> The issue was because dcbst wrongly sets the store bit when causing a 
DTLB
> error, but this is now fixed by commit 
0a2ab51ffb8dfdf51402dcfb446629648c96bc78
> which handles the buggy dcbx instructions on data page faults on the 
8xx.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

 Jocke

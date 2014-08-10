Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 01A371A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Aug 2014 19:09:36 +1000 (EST)
References: <20140808070339.48C4D1ABCF0@localhost.localdomain>
In-Reply-To: <20140808070339.48C4D1ABCF0@localhost.localdomain>
Subject: Re: [PATCH 00/20] powerpc/8xx: Optimise MMU TLB handling and add
 support of 16k pages
MIME-Version: 1.0
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <OF25844E90.2166CD88-ONC1257D30.00319859-C1257D30.0031986B@transmode.se>
Date: Sun, 10 Aug 2014 11:01:42 +0200
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
 This looks really cool! I am on vacation for one more week but I will have=
 a closer
 look once I get back and things get back to normal.

  Jocke
=20

 -----Christophe Leroy <christophe.leroy@c-s.fr> wrote: -----

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <pau=
lus@samba.org>
 From: Christophe Leroy <christophe.leroy@c-s.fr>
 Date: 08/08/2014 9:04=20
 Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Joakim Tj=
ernlund <joakim.tjernlund@transmode.se>, scottwood@freescale.com
 Subject: [PATCH 00/20] powerpc/8xx: Optimise MMU TLB handling and add supp=
ort of 16k pages
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   This patchset:
* provides several MMU TLB handling optimisation on MPC8xx.
* adds support of 16k pages on MPC8xx.
All changes have been successfully tested on a custom board equipped with M=
PC885

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>
    

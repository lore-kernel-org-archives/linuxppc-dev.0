Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 94AFA1007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 22:12:47 +1100 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <prasad@linux.vnet.ibm.com>;
 Thu, 8 Dec 2011 09:12:34 -0200
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pB8BDGPX2322782
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 09:13:17 -0200
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB8BCfAZ016125
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Dec 2011 09:12:42 -0200
Date: Thu, 8 Dec 2011 16:42:12 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: dwg@au1.ibm.com
Subject: [PATCH 0/2] Changes to PowerPC ptrace flags using watchpoints - v2
Message-ID: <20111208111212.GB3720@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,
	Please find a revised version of the patchset which have
incorporated the various suggestions made by you.

Kindly review the patches and let me know if they look fine.

Changelog - v2
--------------
v1 posted at
http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-August/092463.html

- Introduction of a new version number for the hw-breakpoint structures
  dropped.
- The ptrace flag operations are expected to make more precise requests
  and suitable error return codes have been added for incorrect
  requests.
- Modification of an existing breakpoint is not possible. Request an
  delete, followed by set breakpoint request instead.

Thanks,
K.Prasad

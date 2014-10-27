Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 5C7741A20A7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 23:52:05 +1100 (AEDT)
Message-ID: <544E3FF6.7090300@c-s.fr>
Date: Mon, 27 Oct 2014 13:52:06 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Scott Wood <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: What is the reel purpose of in_beXX() and out_beXX() fonctions ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many drivers use in_be16(), in_be32(), out_be16(), out_be32(), etc .... 
to access to registrers in IO mapped memory.

What is the real purpose of those functions, and are they really needed ?

ioremap() maps the related areas as GUARDED, which means that accesses 
can't be speculative. So what is the benefit of using in_beXX() and 
out_beXX() over simple memory accesses in the area ?

Christophe

Return-Path: <michael@ellerman.id.au>
Message-ID: <1343961174.20119.1.camel@concordia>
Subject: Re: [PATCH] powerpc/crypto: Remove virt_to_abs() usage in nx-842.c
From: Michael Ellerman <michael@ellerman.id.au>
To: herbert@gondor.apana.org.au
Date: Fri, 03 Aug 2012 12:32:54 +1000
In-Reply-To: <1343960595-30232-1-git-send-email-michael@ellerman.id.au>
References: <1343960595-30232-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org,
 sjenning@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Herbert,

We're planning on removing virt_to_abs() from the powerpc tree this
cycle. So if you can take this patch in your tree everything should
continue building when the two trees merge.

cheers

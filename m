Return-Path: <or.gerlitz@gmail.com>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0C592C0124
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 06:43:36 +1000 (EST)
Received: by ghbg24 with SMTP id g24so5289975ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 13:43:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50046EB1.5040909@hp.com>
References: <1342458113-10384-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <50044F1D.6000703@hp.com>
 <20120716190611.GA1023@oc1711230544.ibm.com>
 <50046EB1.5040909@hp.com>
Date: Mon, 16 Jul 2012 23:43:33 +0300
Message-ID: <CAJZOPZL3F+xdHSFfhg7v9A6DDjT6CPK=kgwyzcE6c0pGYFyupg@mail.gmail.com>
Subject: Re: [PATCH] mlx4_en: map entire pages to increase throughput
From: Or Gerlitz <or.gerlitz@gmail.com>
To: Rick Jones <rick.jones2@hp.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "leitao@linux.vnet.ibm.com" <leitao@linux.vnet.ibm.com>,
 "amirv@mellanox.com" <amirv@mellanox.com>,
 "yevgenyp@mellanox.co.il" <yevgenyp@mellanox.co.il>,
 "klebers@linux.vnet.ibm.com" <klebers@linux.vnet.ibm.com>,
 "anton@samba.org" <anton@samba.org>,
 "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
 "ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 16, 2012 at 10:42 PM, Rick Jones <rick.jones2@hp.com> wrote:

> I was thinking more along the lines of an additional comparison,
> explicitly using netperf TCP_RR or something like it, not just the packets
> per second from a bulk transfer test.


TCP_STREAM from this setup before the patch would be good to know as well

Return-Path: <or.gerlitz@gmail.com>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF9E92C010E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 06:36:35 +1000 (EST)
Received: by ggnk3 with SMTP id k3so5294445ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 13:36:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50046EB1.5040909@hp.com>
References: <1342458113-10384-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <50044F1D.6000703@hp.com>
 <20120716190611.GA1023@oc1711230544.ibm.com>
 <50046EB1.5040909@hp.com>
Date: Mon, 16 Jul 2012 23:36:31 +0300
Message-ID: <CAJZOPZ+t+bw5u_nLZ21so7X5HeGYm41XFM_AHRihHK23M73a-Q@mail.gmail.com>
Subject: Re: [PATCH] mlx4_en: map entire pages to increase throughput
From: Or Gerlitz <or.gerlitz@gmail.com>
To: Rick Jones <rick.jones2@hp.com>
Content-Type: multipart/alternative; boundary=bcaec555510099512804c4f86279
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "leitao@linux.vnet.ibm.com" <leitao@linux.vnet.ibm.com>,
 "amirv@mellanox.com" <amirv@mellanox.com>,
 "yevgenyp@mellanox.co.il" <yevgenyp@mellanox.co.il>,
 "klebers@linux.vnet.ibm.com" <klebers@linux.vnet.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
 "ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec555510099512804c4f86279
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jul 16, 2012 at 10:42 PM, Rick Jones <rick.jones2@hp.com> wrote:

> I was thinking more along the lines of an additional comparison,
> explicitly using netperf TCP_RR or something like it, not just the packets
> per second from a bulk transfer test.
>

TCP_STREAM would be good to know here as well

Or.

--bcaec555510099512804c4f86279
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, Jul 16, 2012 at 10:42 PM, Rick Jones <span dir=3D"=
ltr">&lt;<a href=3D"mailto:rick.jones2@hp.com" target=3D"_blank">rick.jones=
2@hp.com</a>&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
I was thinking more along the lines of an additional comparison, explicitly=
 using netperf TCP_RR or something like it, not just the packets per second=
 from a bulk transfer test.<span class=3D"HOEnZb"><font color=3D"#888888"><=
/font></span><br>
</blockquote></div><br>TCP_STREAM would be good to know here as well<br><br=
>Or.<br></div>

--bcaec555510099512804c4f86279--

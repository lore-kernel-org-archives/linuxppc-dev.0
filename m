Message-ID: <3C95FF7C.7050300@pacbell.net>
Date: Mon, 18 Mar 2002 14:53:48 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] another for ibm_ocp_enet gzip'd
References: <20020315114137.A26609@ecam.san.rr.com> <20020315200558.GG691@opus.bloom.county> <20020315142542.A27043@ecam.san.rr.com> <20020315223140.GA1643@opus.bloom.county> <20020318142507.A6687@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:

> +#Do we want CONFIG_IBM_OCP_MAL_CNT ?

No

> +ibm_ocp_mal.c: mal.sh
> +	$(SH) ./mal.sh 2 >ibm_ocp_mal.c
> +
>


And this get applied on top of your first patch?

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

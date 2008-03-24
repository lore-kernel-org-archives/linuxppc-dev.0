Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id A15E3DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 00:34:35 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so598133anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 06:34:33 -0700 (PDT)
Message-ID: <fa686aa40803240634o1f0ec81aj7745ea6ec44bdc32@mail.gmail.com>
Date: Mon, 24 Mar 2008 07:34:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] mpc5200: fix incorrect compatible string for
	the mdio node
In-Reply-To: <18407.22329.130304.645554@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1206156315-4734-1-git-send-email-grant.likely@secretlab.ca>
	<18407.22329.130304.645554@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 24, 2008 at 1:24 AM, Paul Mackerras <paulus@samba.org> wrote:
> Grant Likely writes:
>
>  > The MDIO node in the lite5200b.dts file needs to also claim compatibility
>  > with the older mpc5200 chip.
>  >
>  > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>  > ---
>  > Paul, this one should also go in for .26
>
>  OK, I'll put it in the powerpc-next branch.  Or did you mean it should
>  go in .25?

er, oops.  Yes, I really would like this one to go in for .25

Thanks,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

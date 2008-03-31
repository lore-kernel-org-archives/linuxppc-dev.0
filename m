Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 86C37DDF22
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 23:33:36 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so397701anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 06:33:27 -0700 (PDT)
Message-ID: <fa686aa40803310633w5f7ddbccq6960b38d00e9381d@mail.gmail.com>
Date: Mon, 31 Mar 2008 07:33:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: Using FEC on a MPC5200 with default PHY configuration
In-Reply-To: <47F0B26A.10801@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47F0ACC7.9080709@grandegger.com> <47F0B26A.10801@grandegger.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2008 at 3:44 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Wolfgang Grandegger wrote:
>  > Hello,
>  >
>  > is it possible to use the FEC on a MPC5200 with the default hardware PHY
>  > configuration. I mean running the link with a default speed without
>  > handling or even touching the PHY like U-Boot does. I removed the PHY
>  > entries from the DTS file and disabled CONFIG_FEC_MPC52xx_MDIO but it
>  > did not work.
>
>  To be more precise, I want to support a 3-Port managed switch with PHY
>  from Micrel using the direct switch link.

I'm actually working on this exact problem at the moment.  I'll get a
patch out shortly to do so.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.187])
	by ozlabs.org (Postfix) with ESMTP id 2E2CFDE0AE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 02:31:34 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so5514728rnf.16
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Jan 2009 07:31:33 -0800 (PST)
Message-ID: <fa686aa40901050731i3fb3ee2er221af3b174051aa@mail.gmail.com>
Date: Mon, 5 Jan 2009 08:31:33 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
In-Reply-To: <633A55242A59C7488FAAF5A6850929984B816F@SRVEXC01.sts.saurer.vpn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
	<fa686aa40812192318m397aab91kcd1684fe80b52d67@mail.gmail.com>
	<633A55242A59C7488FAAF5A6850929984B816F@SRVEXC01.sts.saurer.vpn>
Cc: Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 5, 2009 at 2:25 AM, Lehmann, Hans (Ritter Elektronik)
<hans.lehmann@ritter-elektronik.de> wrote:
>> Hans, what ATA modes do you see this problem in?  UDMA?  MWDMA?  Or does just having the patch applied but still using PIO mode expose the problem?
>
>
> This problem occurs in MWDMA 2 mode.

Thanks Hans.  DMA support is now in mainline, but it is disabled by
default.  It shouldn't break anything if MWDMA or UDMA does not get
enabled.  Let me know if it causes you any problems.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

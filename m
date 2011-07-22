Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7859B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 05:41:28 +1000 (EST)
Received: by vxi32 with SMTP id 32so2019571vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 12:41:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110719115545.52efca3d@schlenkerla.am.freescale.net>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-5-git-send-email-dbaryshkov@gmail.com>
	<20110719115545.52efca3d@schlenkerla.am.freescale.net>
Date: Fri, 22 Jul 2011 23:41:24 +0400
Message-ID: <CALT56yMwL1B7D1xi-Sq7z7pLjJ1TP3-h9MQC==-MJnZwPF_T5w@mail.gmail.com>
Subject: Re: [PATCH 04/14] 83xx/mpc834x_itx: drop pq2pro-localbus-specific code
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/19/11, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, 19 Jul 2011 12:53:41 +0400
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>
>> As localbus on mpc8349e-mitx now provides simple-bus compatibility, we
>> can drop code asking for pq2pro-localbus devices on mpc834x_itx boards.
>
> Do we have a good reason for breaking compatibility with older device trees?

Hmm. No real reason if you look from this POV. Just didn't thought in
this direction.

BTW: Documentation/devicetree/fsl/lbc.txt doesn't talk at all about "compatible"
property. Maybe one can add there something (like asking to add simple-bus
for new platforms). I feel myself too unexperienced to fix that.

-- 
With best wishes
Dmitry

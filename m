Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.250])
	by ozlabs.org (Postfix) with ESMTP id F0E71DDF32
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 17:09:16 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so4688521agc.0
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 00:09:14 -0700 (PDT)
Message-ID: <fa686aa40806290009o23aeec90i2ec2baebb155fbd0@mail.gmail.com>
Date: Sun, 29 Jun 2008 01:09:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jcrigby@gmail.com>
Subject: Re: [Resend][PATCH 1/8][Version 2] MPC5121 Update MPC5121ADS device
	tree
In-Reply-To: <20080629061533.GL13876@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080625203051.4FE882F123B@rumpole.eng.lineo.com>
	<20080627014233.GB17621@yookeroo.seuss>
	<4b73d43f0806262040s7993dcb7vd8a3d05793ea8a7@mail.gmail.com>
	<20080629061533.GL13876@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 29, 2008 at 12:15 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Thu, Jun 26, 2008 at 09:40:57PM -0600, John Rigby wrote:
>> Because get_immrbase in fsl_soc.c does not work without it.
>
> I think I'd rather see get_immrbase() instead then.

er, I think I'd rather see get_immrbase() *fixed* instead then.

g.

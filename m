Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id E841DDE076
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 00:11:52 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1682508yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 07:11:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200905181557.11766.kosmo@semihalf.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
	<4A028182.3040107@grandegger.com>
	<200905181557.11766.kosmo@semihalf.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 18 May 2009 08:11:30 -0600
Message-ID: <fa686aa40905180711l5f85320n9508852f74f0b7b9@mail.gmail.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
To: =?ISO-8859-2?Q?Piotr_Zi=EAcik?= <kosmo@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/5/18 Piotr Zi=EAcik <kosmo@semihalf.com>:
>> Right. Furthermore, the i2c-mpc.c should be extened to support bus speed
>> setting for the MPC512x, which has been merged recently (see commit id
>> f2bd5efe).
>
> I have simple question about bus speed setting support. Existing
> implementation uses default safe speed if there is no 'clock-frequency'
> property in i2c node. Comments in code suggest that this behaviour is lef=
t
> for backward compatibility only. Should I make the 'clock-frequency'
> property mandatory for a new type of I2C controller (MPC5121) ?

yes.  At least in documentation, but I wouldn't do extra work to
disable that behaviour for 5121 boards.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CD5EEDE050
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 00:29:09 +1000 (EST)
Message-ID: <4A1170B0.5080203@grandegger.com>
Date: Mon, 18 May 2009 16:29:04 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Piotr_Zi=EAcik?= <kosmo@semihalf.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
	<4A028182.3040107@grandegger.com>
	<200905181557.11766.kosmo@semihalf.com>
In-Reply-To: <200905181557.11766.kosmo@semihalf.com>
Content-Type: text/plain; charset=iso-8859-2
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Piotr Ziêcik wrote:
>> Right. Furthermore, the i2c-mpc.c should be extened to support bus speed
>> setting for the MPC512x, which has been merged recently (see commit id
>> f2bd5efe).
> 
> I have simple question about bus speed setting support. Existing 
> implementation uses default safe speed if there is no 'clock-frequency' 
> property in i2c node. Comments in code suggest that this behaviour is left 
> for backward compatibility only. Should I make the 'clock-frequency'
> property mandatory for a new type of I2C controller (MPC5121) ?

I don't think so, for the same backward compatibility reason as for the
other boards. But the DTS file might be changed to use clock-frequency.
BTW, when I wrote the code I already had the MPC512x in mind. IIRC, the
FDR table and the function scanning it for the MPC52xx should work for
the MPC512x as well. It's mainly a matter of using the proper function
to get the source clock frequency and fiddling with multiple-arch support.

Wolfgang.

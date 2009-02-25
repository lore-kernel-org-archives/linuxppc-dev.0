Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id 8E174DDEE9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 23:27:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: PPC 405 EX USB Development
Date: Wed, 25 Feb 2009 13:27:01 +0100
References: <d9c5f2890902250115s3867904fj22e8f5af2d469581@mail.gmail.com>
In-Reply-To: <d9c5f2890902250115s3867904fj22e8f5af2d469581@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200902251327.02082.sr@denx.de>
Cc: Adish Kuvelker <adish.kuvelker@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 February 2009, Adish Kuvelker wrote:
> I am developing a Host Controller Driver for the PPC405EX based board. I
> have a OTG controller on it, which I have to configure as Host Controller
> and thus I am witting a HCD for the same. I am stuck at the Control stage
> wherein although my SETUP stage seems to be going through I get a STALL.
>
> Can anyone help me in this regard as to where would I get a reference code
> for this?

Are you talking about the 405EX internal USB OTG controller (Synopsys DWC) or 
some other OTG controller? 

Best regards,
Stefan

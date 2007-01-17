Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 3D2BADDF0F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 19:44:21 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1886811ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 00:44:19 -0800 (PST)
Message-ID: <528646bc0701170044h7d7217bs3c8f45aeca1efcee@mail.gmail.com>
Date: Wed, 17 Jan 2007 01:44:19 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Liu Dave-r63238" <DaveLiu@freescale.com>
Subject: Re: Warnings when booting rc5 on a mpc83xx based board
In-Reply-To: <995B09A8299C2C44B59866F6391D26355F3456@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <F6AD7E21CDF4E145A44F61F43EE6D939C688E7@tmnt04.transmode.se>
	<995B09A8299C2C44B59866F6391D26355F3456@zch01exm21.fsl.freescale.net>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/17/07, Liu Dave-r63238 <DaveLiu@freescale.com> wrote:
> The OF is really painful for embedded system.

For the record; I have to disagree.  I find the device tree cleans up
and makes more maintainable a lot of my code.  It gets rid of a lot of
my crazy-ass hacks for using different SoC configurations on different
boards.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

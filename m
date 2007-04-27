Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id DD47FDDFCF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 22:12:01 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] SystemACE driver - abstract register ops
Date: Fri, 27 Apr 2007 14:11:35 +0200
References: <463199EF.3090900@itee.uq.edu.au>
	<528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
In-Reply-To: <528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200704271411.36090.sr@denx.de>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <rick.moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 27 April 2007 09:31, Grant Likely wrote:
> For your reading pleasure, I've attached the bus attachment changes
> that I've made in my tree.  I hope to get this driver accepted into
> mainline during the 2.6.22 merge window; so please get any comments
> you have back to me ASAP.

Works fine on my Katmai 440SPe system with SysACE connected in 16bit 
big-endian mode. Thanks.

Acked-by Stefan Roese <sr@denx.de>

Best regards,
Stefan

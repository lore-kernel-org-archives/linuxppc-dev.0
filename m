Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4062FDDF84
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 01:12:09 +1000 (EST)
Received: from outbound2-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-sin-R.bigfish.com (Postfix) with ESMTP id ECA1414F6F3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 15:12:06 +0000 (UTC)
Received: from mail42-sin-R.bigfish.com (unknown [10.3.252.3])
	by outbound2-sin.bigfish.com (Postfix) with ESMTP id DFE29528067
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 15:12:06 +0000 (UTC)
Received: from mail42-sin (localhost.localdomain [127.0.0.1])
	by mail42-sin-R.bigfish.com (Postfix) with ESMTP id 9E9021288102
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 15:12:06 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail42-sin.bigfish.com (Postfix) with ESMTP id 3CB1E29007E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 15:12:06 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX1/P78pVTABw54+8j8ZaD1jLWJAtFf2+yf8=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <wolfgang.reissnegger@xilinx.com>) id 1INrsL-0008Hc-DC
	for linuxppc-embedded@ozlabs.org; Wed, 22 Aug 2007 08:12:05 -0700
Date: Wed, 22 Aug 2007 08:12:03 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [Fwd: Re: [PATCH 3/3] Add support for xupv2p and ml410 boards.]
Content-Type: multipart/mixed; boundary="------------070600000702040800020303"
Message-Id: <20070822151206.3CB1E29007E@mail42-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070600000702040800020303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------070600000702040800020303
Content-Type: message/rfc822;
 name*0="Re: [PATCH 3/3] Add support for xupv2p and ml410 boards."
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Re: [PATCH 3/3] Add support for xupv2p and ml410 boards."

Message-ID: <46CBB489.3080700@xilinx.com>
Date: Tue, 21 Aug 2007 20:59:05 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
MIME-Version: 1.0
To: Robert Woodworth <rwoodworth@securics.com>
Subject: Re: [PATCH 3/3] Add support for xupv2p and ml410 boards.
References: <1187743993171-git-send-email-wolfgang.reissnegger@xilinx.com>	 <1187743993360-git-send-email-wolfgang.reissnegger@xilinx.com>	 <20070822005048.CF66B31005A@mail77-blu.bigfish.com> <1187751864.6266.6.camel@PisteOff>
In-Reply-To: <1187751864.6266.6.camel@PisteOff>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Robert Woodworth wrote:
> Should the xparameters????.h file *really* be included in the tree?
> 
> This file is completely board/EDK/ISE/synthesis specific.  I'd rather
> it not be included and have people copy theirs from EDK. Or as I have
> done, sym-link it from my EDK project.
> 
> Woody.

The purpose of the included xparameter.h files is to provide a
configuration for the default reference designs. They are useful if you
want to compile a kernel without building a system with the EDK first.
As Grant pointed out, for custom designs you'd need to generate your own
xparameter.h file.

Wolfgang




--------------070600000702040800020303--

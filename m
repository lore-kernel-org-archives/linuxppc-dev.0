Return-Path: <suvidh.kankariya@ntigo.com>
Received: from nti1.com (nti1.com [65.243.248.10])
	by ozlabs.org (Postfix) with ESMTP id 3B540DDE28
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 04:31:21 +1000 (EST)
Received: from [65.243.248.64] (host64.networktechinc.com [65.243.248.64] (may
	be forged)) by nti1.com (8.14.1/8.14.1) with ESMTP id m4NIVFtB029919
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 14:31:18 -0400 (EDT)
Message-ID: <48370DB6.7030003@ntigo.com>
Date: Fri, 23 May 2008 14:32:22 -0400
From: Suvidh Kankariya <suvidh.kankariya@ntigo.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: help with USB on mpc8313e
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I am trying to use the mpc8313e internal usb phy with internal 
oscillator frequency of  24 Mz. in host mode on a custom board.
Whenever I plugin any low/fast speed device the device gets detected but 
then always get an error
"cannot read descriptor 64  error 71".Also I get address error after that .

Can somebody point me what this error can be related to ?Can it be a 
problem with ehci drivers or some configuration. (I get a valid clock 
bit set in the status register).

Also can someone point me how I include support for mmc on spi. I am 
using kernel 2.6.20 that comes along with mpc8313e bsp.

Any pointers are highly appreciable.

Thanks in advance
Regards

Suvidh

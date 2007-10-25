Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id 286D5DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 23:53:54 +1000 (EST)
Subject: Re: kernel 2.6.15: cpm_uart driver broken?
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF783A222E.1D5A56A4-ONC125737F.004B8502-C125737F.004C5724@abengoa.com>
Date: Thu, 25 Oct 2007 15:54:07 +0200
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi,

I've found this thread, but I haven't seen the end of the discussion. I=
 am
using this kernel version, and I am also having problems with the cpm_u=
art.
Only the console (SMC1) is working, the other devices working as uart f=
ail.
I've realised that the problem is in the DMA. The system crash when the=
 Rx
and Tx buffers are allocated in external memory (in case of allocating =
in
the DPRAM of my mpc866, it works properly) and I don't know why. It is
supposed other devices (as fec) use the same functions
("dma_alloc_coherent") and they work.

Moreover I don't find any documentation about the parameters
"CONFIG_CONSISTENT_START" and "CONFIG_CONSISTENT_SIZE". Does these
parameters affect to the driver behaviour?

Could anyone help me?

Kind regards,

Ra=FAl Moreno
***********Internet Email Confidentiality Footer*************
This email and any files transmitted with it are confidential and inten=
ded
solely for the use of the organization or individual to whom they are
addressed.  It is expressly forbidden to retransmit or copy email and/o=
r
this  attached files without our permission .  If you are not the
addressee indicated in this message (or responsible for delivery of the=

message to such person), you may not copy or deliver this message
to anyone. In such case, you should destroy this message and kindly
notify the sender by reply email. Please advise immediately if you or
your employer does not consent to Internet email for messages of this
kind.  Opinions, conclusions and other information in this message that=

do not relate to the official business of my firm shall be understood a=
s
neither given nor endorsed by it.=

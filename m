Return-Path: <bms.monteiro@gmail.com>
Received: from mail-gx0-f14.google.com (mail-gx0-f14.google.com
	[209.85.217.14]) by ozlabs.org (Postfix) with ESMTP id 4199BDDDED
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Oct 2008 01:40:56 +1100 (EST)
Received: by gxk7 with SMTP id 7so7951475gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Oct 2008 07:40:54 -0700 (PDT)
Message-ID: <d43ae5a00810210735k2e2068aew3e67e36bd079805@mail.gmail.com>
Date: Tue, 21 Oct 2008 15:35:44 +0100
From: "Bruno Monteiro" <bms.monteiro@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Compile program using XGpio
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10192_1171376.1224599744224"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_10192_1171376.1224599744224
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I'm working with a Virtex2p. I have a running system using:

   - EDK 9.1
   - Crosstool-ng (svn)
   - linux-2.6-xlnx
   - BusyBox 1.12.1

Now, i'm trying to build a small program that turn off leds. I guess it
should be something like this:

void main (void){
    XGpio led;
    XGpio_Initialize (&led, XPAR_LEDS_4BIT_DEVICE_ID);
    XGpio_SetDataDirection(&led,1,0);
    XGpio_DiscreteWrite(&led,1,0xf);
}


I want to know how to compile it (without EDK). Any suggestion?


Thanks,
Bruno Monteiro

------=_Part_10192_1171376.1224599744224
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>I&#39;m working with a Virtex2p. I have a running system using:<br><ul><li>EDK 9.1<br></li><li>Crosstool-ng (svn)</li><li>linux-2.6-xlnx</li><li>BusyBox 1.12.1</li></ul>Now, i&#39;m trying to build a small program that turn off leds. I guess it should be something like this:<br>
<br><div style="margin-left: 40px;">void main (void){<br>&nbsp;&nbsp;&nbsp; XGpio led;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; XGpio_Initialize (&amp;led, XPAR_LEDS_4BIT_DEVICE_ID);<br>&nbsp;&nbsp;&nbsp; XGpio_SetDataDirection(&amp;led,1,0);<br>&nbsp;&nbsp;&nbsp; XGpio_DiscreteWrite(&amp;led,1,0xf);&nbsp;&nbsp;&nbsp; <br>
}<br><br></div><br>I want to know how to compile it (without EDK). Any suggestion? <br><br><br>Thanks,<br>Bruno Monteiro <br><br>

------=_Part_10192_1171376.1224599744224--

Return-Path: <nhickman@dtechlabs.com>
Received: from mail.dtechlabs.com
	(ip66-104-11-166.z11-104-66.customer.algx.net [66.104.11.166])
	by ozlabs.org (Postfix) with SMTP id 0848ADDF0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 02:03:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: SPI driver?
Date: Tue, 11 Sep 2007 11:50:56 -0400
Message-ID: <8140AAF341CC904BA92C3D6A5A1909782F0D4F@ditech-1.ditechllc.com>
In-Reply-To: <46E56DEA.3060205@Sun.COM>
From: "Nicholas Hickman" <nhickman@dtechlabs.com>
To: <Hesam.Kohanteb@Sun.COM>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am also in search of this, or some information about one.  Please let
me know if you find anything.

I ran across an existing platform that used an mpc8270.  During boot up
it displayed:
[   17.828513] SPIDriver: module license 'Proprietary' taints kernel.
[   17.865052] CPM SPI Driver: $Revision: 1.0 $ wd@denx.de

I have been all over denx and have not been able to find it.  This
particular system used the SPI for a DSP chip.=20



-Nick

-----Original Message-----
From: linuxppc-embedded-bounces+nhickman=3Ddtechlabs.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+nhickman=3Ddtechlabs.com@ozlabs.org] =
On
Behalf Of Hesam Kohanteb
Sent: Monday, September 10, 2007 12:17 PM
To: linuxppc-embedded@ozlabs.org
Subject: SPI driver?

We need a Linux based SPI driver for MPC885. Do you know where can I
possibly find the code.

Regards. --Hesam

--
Hesam Yehuda Kohanteb
(Netra Systems & Networking),
M/S USCA12-216  4120 Network Circle
Santa Clara, CA  95054
(W) 408-276-7329 X17329, Fax 408-276-4552

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

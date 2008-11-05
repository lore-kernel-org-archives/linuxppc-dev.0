Return-Path: <lk.atwork@yahoo.com>
Received: from n26.bullet.mail.mud.yahoo.com (n26.bullet.mail.mud.yahoo.com
	[68.142.206.221]) by ozlabs.org (Postfix) with SMTP id ACC58DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Nov 2008 06:22:37 +1100 (EST)
References: <131123.51430.qm@web46312.mail.sp1.yahoo.com>
	<4911C695.4070401@freescale.com>
Date: Wed, 5 Nov 2008 11:22:35 -0800 (PST)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: i2c driver's probe routine not getting called
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1496673244-1225912955=:15414"
Message-ID: <789886.15414.qm@web46310.mail.sp1.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1496673244-1225912955=:15414
Content-Type: text/plain; charset=us-ascii

I actually tried using the in tree i2c-mpc driver before sending out my email. This driver would silently reset the system when i2c accesses took place.

So I guess I'll try to modify the old driver to support new OF interface.

thanks
LK




________________________________
From: Scott Wood <scottwood@freescale.com>
To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Sent: Wednesday, November 5, 2008 8:15:17 AM
Subject: Re: i2c driver's probe routine not getting called

Laxmikant Rashinkar wrote:
> I have linux-2.6.27.1 running on a MPC8347 based board.
> 
> When my freescale I2C driver is insmoded, it calls platform_driver_register() successfully, but the probe routine doesn't get called. 

Is "your" freescale I2C driver different from "the" freescale I2C driver in drivers/i2c/busses/i2c-mpc.c?  If so, you'll need to update it to be an of_platform driver like the in-tree driver is (or, just switch to the in-tree driver).

-Scott



      
--0-1496673244-1225912955=:15414
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:12pt"><div>I actually tried using the in tree i2c-mpc driver before sending out my email. This driver would silently reset the system when i2c accesses took place.<br><br>So I guess I'll try to modify the old driver to support new OF interface.<br><br>thanks<br>LK<br></div><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;"><br><div style="font-family: arial,helvetica,sans-serif; font-size: 12pt;"><font face="Tahoma" size="2"><hr size="1"><b><span style="font-weight: bold;">From:</span></b> Scott Wood &lt;scottwood@freescale.com&gt;<br><b><span style="font-weight: bold;">To:</span></b> Laxmikant Rashinkar &lt;lk.atwork@yahoo.com&gt;<br><b><span style="font-weight: bold;">Cc:</span></b> linuxppc-embedded@ozlabs.org<br><b><span style="font-weight: bold;">Sent:</span></b>
 Wednesday, November 5, 2008 8:15:17 AM<br><b><span style="font-weight: bold;">Subject:</span></b> Re: i2c driver's probe routine not getting called<br></font><br>
Laxmikant Rashinkar wrote:<br>&gt; I have linux-2.6.27.1 running on a MPC8347 based board.<br>&gt; <br>&gt; When my freescale I2C driver is insmoded, it calls platform_driver_register() successfully, but the probe routine doesn't get called. <br><br>Is "your" freescale I2C driver different from "the" freescale I2C driver in drivers/i2c/busses/i2c-mpc.c?&nbsp; If so, you'll need to update it to be an of_platform driver like the in-tree driver is (or, just switch to the in-tree driver).<br><br>-Scott<br></div></div></div><br>

      </body></html>
--0-1496673244-1225912955=:15414--

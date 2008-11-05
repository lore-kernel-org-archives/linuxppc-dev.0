Return-Path: <lk.atwork@yahoo.com>
Received: from n63.bullet.mail.sp1.yahoo.com (n63.bullet.mail.sp1.yahoo.com
	[98.136.44.33]) by ozlabs.org (Postfix) with SMTP id 9D3B8DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Nov 2008 14:38:13 +1100 (EST)
Date: Tue, 4 Nov 2008 19:38:11 -0800 (PST)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: request_irq issue
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2045709385-1225856291=:58773"
Message-ID: <681154.58773.qm@web46308.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2045709385-1225856291=:58773
Content-Type: text/plain; charset=us-ascii

Hi,

I have a MPC8347 based board that runs linux-2.6.15.4 and 2.6.27.1.

With the older Linux, my driver is able to successfully request_irq() interrupts 17, 18, 19, 20, 21, 22, 23 & 48.

But with the newer linux, request_irq() works only for 17, 18 & 19. cat /proc/interrupts shows that none of the interrupts above are in use.
Any pointers on why request_irq() is behaving thus?

thanks for your help
LK



      
--0-2045709385-1225856291=:58773
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:12pt"><div>Hi,<br><br>I have a MPC8347 based board that runs linux-2.6.15.4 and 2.6.27.1.<br><br>With the older Linux, my driver is able to successfully request_irq() interrupts 17, 18, 19, 20, 21, 22, 23 &amp; 48.<br><br>But with the newer linux, request_irq() works only for 17, 18 &amp; 19. cat /proc/interrupts shows that none of the interrupts above are in use.<br>Any pointers on why request_irq() is behaving thus?<br><br>thanks for your help<br>LK<br></div></div><br>

      </body></html>
--0-2045709385-1225856291=:58773--

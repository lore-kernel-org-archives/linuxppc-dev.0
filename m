Return-Path: <bharthik2004@yahoo.com>
Received: from web50810.mail.yahoo.com (web50810.mail.yahoo.com
	[206.190.38.253]) by ozlabs.org (Postfix) with SMTP id 8614B67D1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 21:17:40 +1100 (EST)
Message-ID: <20061108101058.42357.qmail@web50810.mail.yahoo.com>
Date: Wed, 8 Nov 2006 02:10:58 -0800 (PST)
From: bharathi kandimalla <bharthik2004@yahoo.com>
Subject: Mpc860T rebooting problem
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1726535906-1162980658=:41076"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1726535906-1162980658=:41076
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi
  I am working on powerpc(Mpc860T) with linux-2.4 kernnel,
As I am developping  application using spi and with irqs: 
For each one millisec I am getting siu interrupt,In the 
interrupt handler I have to load frequency(using spi communication)
I am able to write it (I am able load the frequency also)
  All other interrupts I am using are  cpm interrupts(smc2.timer2,spi),one 
siu interrupt for the present ,
I am facing the following problems:
1.system rebooting: case-if i tried to write continuously to externel hardware through spi ,in externel (siu)intrrupt handler,and timer2(cpm)intrrupt handler,
2. if I limited number of times of write to hardware system not getting rebooted.
  
  I  observed that the problem occured due to passing of control signals to externel hardware (those are memory mapped signals) in irqs.how can i solve this with getting rebooted.
 thanks to all ...
  Bharathi

 
---------------------------------
Sponsored Link

Degrees online in as fast as 1 Yr - MBA, Bachelor's, Master's, Associate - Click now to apply
--0-1726535906-1162980658=:41076
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>hi</div>  <div>I am working on powerpc(Mpc860T) with linux-2.4 kernnel,<BR>As I am developping&nbsp; application using spi and with irqs: <BR>For each one millisec I am getting siu interrupt,In the <BR>interrupt handler I have to load frequency(using spi communication)<BR>I am able to write it (I am able load the frequency also)</div>  <div>All other interrupts I am using are&nbsp; cpm interrupts(smc2.timer2,spi),one&nbsp;<BR>siu interrupt for the present&nbsp;,<BR>I am facing the following problems:<BR>1.system rebooting: case-if i tried to write continuously to externel hardware through spi ,in externel (siu)intrrupt handler,and timer2(cpm)intrrupt handler,<BR>2. if I limited number of times of write to hardware system not getting rebooted.</div>  <div><BR>&nbsp;&nbsp;I &nbsp;observed that the problem occured due to passing of control signals to externel hardware (those are memory mapped signals) in irqs.how can i solve this with getting rebooted.<BR>&nbsp;thanks to
 all ...</div>  <div>Bharathi</div><p>&#32;


<hr size=1>Sponsored Link<br><br>
Degrees online in as fast as 1 Yr - MBA, Bachelor's, Master's, Associate - <a href="http://online.degrees.info/forms/form.jsp?ADEL=D3sPPz6WYLD7%2FD1DxMxP%2BbXooR4YcdmONmTWaUizNjh6q2wGRcnxuw%3D%3D&PI=y_mail_textlink">Click now to apply</a>
--0-1726535906-1162980658=:41076--

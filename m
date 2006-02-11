Return-Path: <bharthik2004@yahoo.com>
Received: from web50003.mail.yahoo.com (web50003.mail.yahoo.com
	[206.190.38.18]) by ozlabs.org (Postfix) with SMTP id F256367B3F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 17:37:47 +1100 (EST)
Message-ID: <20060211063745.23407.qmail@web50003.mail.yahoo.com>
Date: Fri, 10 Feb 2006 22:37:45 -0800 (PST)
From: bharathi kandimalla <bharthik2004@yahoo.com>
Subject: accessing serial port  of  MPC860T 
To: jagadish <jagadish@india.advinfo.net>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-338671634-1139639865=:22932"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-338671634-1139639865=:22932
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

             
Hi
  I am able to open the scc2 port from the user space application
but I am not able to write to the device.
I think write function is not implemented correctly 
even if I wrote code for  write function in the file 
cpm_uart_cpm1.c it is effecting console  port
  As the code comes from the linux 2.6.13  for the 
Mpc860T  works correctly? /or it requires some modifications to work properly 
 If the port (SMC2 OR SCC1 OR SMC] is configured as the CONSOLE  it is working fine     
  best regards
BHARATHI
   

			
---------------------------------
 Yahoo! Mail
 Use Photomail to share photos without annoying attachments.
--0-338671634-1139639865=:22932
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>Hi</div>  <div>I am able to open the scc2 port from the user space application<BR>but I am not able to write to the device.<BR>I think write function is not implemented correctly <BR>even if I wrote code for&nbsp; write function in the file <BR>cpm_uart_cpm1.c it is effecting console&nbsp; port</div>  <div>As the code comes from the linux 2.6.13&nbsp; for the <BR>Mpc860T&nbsp; works correctly? /or it requires some modifications to work properly <BR>&nbsp;If the port (SMC2 OR SCC1 OR SMC] is configured as the CONSOLE&nbsp; it is working fine&nbsp;&nbsp;&nbsp;&nbsp; </div>  <div>best regards<BR>BHARATHI</div>  <div>&nbsp;</div><p>
	
		<hr size=1> Yahoo! Mail<br> 
<a href="http://us.rd.yahoo.com/mail_us/taglines/pmall2/*http://photomail.mail.yahoo.com">Use Photomail</a> to share photos without annoying attachments.
--0-338671634-1139639865=:22932--

Return-Path: <sheldoninstruments@yahoo.com>
Received: from web37803.mail.mud.yahoo.com (web37803.mail.mud.yahoo.com
	[209.191.87.116]) by ozlabs.org (Postfix) with SMTP id C861E67B52
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 02:02:15 +1000 (EST)
Message-ID: <20060808155533.33325.qmail@web37803.mail.mud.yahoo.com>
Date: Tue, 8 Aug 2006 08:55:33 -0700 (PDT)
From: Eric Heim <sheldoninstruments@yahoo.com>
Subject: MPC8349 clocking
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-31737000-1155052533=:32181"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-31737000-1155052533=:32181
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Anyone know of a patch for the MPC8349 clocking scheme.  All my time tests are indicating that the clock is running at half speed though I see no indication in the /proc/cpuinfo.  I run a sleep(5) and it takes ten seconds but gettimeofday( ) and the time base register indicate that 5 seconds passed.
 
 Tim
 
 			
---------------------------------
See the all-new, redesigned Yahoo.com.  Check it out.
--0-31737000-1155052533=:32181
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Anyone know of a patch for the MPC8349 clocking scheme.&nbsp; All my time tests are indicating that the clock is running at half speed though I see no indication in the /proc/cpuinfo.&nbsp; I run a sleep(5) and it takes ten seconds but gettimeofday( ) and the time base register indicate that 5 seconds passed.<br> <br> Tim<br> <p>&#32;
	
		<hr size=1>See the all-new, redesigned Yahoo.com. <a href="http://us.rd.yahoo.com/evt=40762/*http://www.yahoo.com/preview"> Check it out.</a>

--0-31737000-1155052533=:32181--

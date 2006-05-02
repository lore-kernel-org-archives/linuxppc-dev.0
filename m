Return-Path: <sheldoninstruments@yahoo.com>
Received: from web37812.mail.mud.yahoo.com (web37812.mail.mud.yahoo.com
	[209.191.87.125]) by ozlabs.org (Postfix) with SMTP id C7EBC67A00
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 08:02:44 +1000 (EST)
Message-ID: <20060502220242.2001.qmail@web37812.mail.mud.yahoo.com>
Date: Tue, 2 May 2006 15:02:42 -0700 (PDT)
From: Eric Heim <sheldoninstruments@yahoo.com>
Subject: cfg_lock
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-550463469-1146607362=:98609"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-550463469-1146607362=:98609
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Anybody know how the cfg_lock bit is manipulated on the MPC8349EMDS board?  I know the bit is in the internal configuration registers but how is this bit flipped on boot?  We are trying to boot the board as an agent in a PC.  We can only do this using the hard coded option.  We would like to boot the board with the reset config word in the I2C but we can't boot the board with the 'core disabled' as we would like(it only works if the core enable bit is set, otherwise the PC hangs and won't boot).  We are hoping to use a pre-load command in the boot sequencer,  but there is little information on how this can be done or if it can be done.  We can flip the bit from u-boot or using our driver when the PC has booted up but we need some way to flip the bit during boot to allow our PC to get its proper configuration cycles.  Any ideas?

		
---------------------------------
How low will we go? Check out Yahoo! Messenger’s low  PC-to-Phone call rates.
--0-550463469-1146607362=:98609
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Anybody know how the cfg_lock bit is manipulated on the MPC8349EMDS board?&nbsp; I know the bit is in the internal configuration registers but how is this bit flipped on boot?&nbsp; We are trying to boot the board as an agent in a PC.&nbsp; We can only do this using the hard coded option.&nbsp; We would like to boot the board with the reset config word in the I2C but we can't boot the board with the 'core disabled' as we would like(it only works if the core enable bit is set, otherwise the PC hangs and won't boot).&nbsp; We are hoping to use a pre-load command in the boot sequencer,&nbsp; but there is little information on how this can be done or if it can be done.&nbsp; We can flip the bit from u-boot or using our driver when the PC has booted up but we need some way to flip the bit during boot to allow our PC to get its proper configuration cycles.&nbsp; Any ideas?<br><p>
		<hr size=1>How low will we go? Check out Yahoo! Messenger’s low <a href="http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone call rates.
--0-550463469-1146607362=:98609--

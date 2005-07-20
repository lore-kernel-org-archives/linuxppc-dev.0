Return-Path: <madhuri_shilpi@yahoo.com>
Received: from web61319.mail.yahoo.com (web61319.mail.yahoo.com
	[209.73.179.73]) by ozlabs.org (Postfix) with SMTP id ACA9167CB2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 19:13:43 +1000 (EST)
Message-ID: <20050720090701.82007.qmail@web61319.mail.yahoo.com>
Date: Wed, 20 Jul 2005 02:07:00 -0700 (PDT)
From: madhuri shilpi <madhuri_shilpi@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: MPC5200 revisions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
  
   Have anyone tried to make MPC5200 Rev.A or Rev.B to
go into Deep Sleep Mode. I tried some methods but
enabling "ccs_sleep_en" bit in in CDM clock Control
Sequencer (MBAR + 0x021C) just wont make it go to
sleep. Does anyone has any experiences with it. If yes
please do share them. 

  I heard that MPC5200 Rev.A has some hardware
problems regarding this DeepSleep Mode (I dont know
what exactly it is) .. assuming that the newer version
doesnt have it, why setting the ccs_sleep_en bit have
no effect on the core ???

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

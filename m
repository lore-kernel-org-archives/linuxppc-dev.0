Return-Path: <junita_ppc@yahoo.com>
Received: from web53701.mail.yahoo.com (web53701.mail.yahoo.com
	[206.190.37.22]) by ozlabs.org (Postfix) with SMTP id 9F73567A2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 03:45:24 +1000 (EST)
Message-ID: <20050412173842.73101.qmail@web53701.mail.yahoo.com>
Date: Tue, 12 Apr 2005 10:38:41 -0700 (PDT)
From: Junita Ajith <junita_ppc@yahoo.com>
To: linuxppc-embedded@ozlabs.org, pari@gdatech.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Help needed Linux-2.6 - MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi
   We are trying to port Linux-2.6 for our custom
MPC8541 board.

   We have a TSEC and an FEC in the board.

With the "Networking Support" disabled in the Kernel,
the board boots up fine and gets to the prompt.

   But with the "Networking Support" enabled in the
kernel  the board hangs where it identifies the PHY,
inspite of giving the corrct PHY ID.


   Any help is greatly appreciated.

PS:
    We have linux-2.4 ported for the same board and so
 taking that as reference trying to port Linux-2.6 ,
 but havent succeeded yet.

 Thanks
 Junita


		
__________________________________ 
Do you Yahoo!? 
Make Yahoo! your home page 
http://www.yahoo.com/r/hs

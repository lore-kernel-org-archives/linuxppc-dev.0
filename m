Return-Path: <annamaya@yahoo.com>
Received: from web53805.mail.yahoo.com (web53805.mail.yahoo.com
	[206.190.36.200]) by ozlabs.org (Postfix) with SMTP id F0D3067A78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 04:49:16 +1100 (EST)
Message-ID: <20050125174913.42739.qmail@web53805.mail.yahoo.com>
Date: Tue, 25 Jan 2005 09:49:13 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Additional data/instruction BATs not initialized for MPC8280?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have read in the specs for the MPC8280 that it has a
G2_LE core which has 4 additional data and instruction
BATs. However, I dont see these BATS being cleared
early in the kernel. I only see that the first 4 pairs
are cleared using the mtspr instructions. But my
kernel comes up just fine and everything seems to work
OK. Dont we need to clear the other set of I/DBATS?
What happens when we dont do this? Thanks in advance.


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

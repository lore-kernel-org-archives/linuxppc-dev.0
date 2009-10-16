Return-Path: <jeff@theptrgroup.com>
Message-ID: <4AD8CD30.6020003@theptrgroup.com>
Date: Fri, 16 Oct 2009 15:44:48 -0400
From: Jeff Angielski <jeff@theptrgroup.com>
MIME-Version: 1.0
To: Linuxppc-dev@lists.ozlabs.org, Joel Lord <Lord@Assurtech.com>
Subject: c67x00 with mpc85xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We are using the Cypress USB Host (CY7C67300) with a Freescale MPC8544 
and can only get it to work if we add a delay after writing to the 
hardware registers through the HPI.

We tried playing with the SCY settings in the GPCM but nothing helps. 
It is only when we add usecs of delay after our write() functions that 
the hardware works.

The datasheets make no mention of any write-then-read requirements and 
the FAEs are stumped right now.

I was just hoping somebody had some experiencing interfacing this chip 
to the PowerPC and that they could offer some suggestions or ideas.


TIA,
Jeff


-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com

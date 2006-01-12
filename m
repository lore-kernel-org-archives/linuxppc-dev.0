Return-Path: <wd@denx.de>
To: batsayan.das@tcs.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Jan 2006 10:46:05 +0530."
	<OF08F91C71.313412E8-ON652570F4.001BB5F4-652570F4.001CF070@tcs.com>
Date: Thu, 12 Jan 2006 08:39:22 +0100
Sender: wd@denx.de
Message-Id: <20060112073922.05CCA353CCD@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet not initialized: Help req 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OF08F91C71.313412E8-ON652570F4.001BB5F4-652570F4.001CF070@tcs.com> you wrote:
> 
> BTW, is there any tool/test case available to test the ethernet driver for 
> a long period of time? 

Mount the root file system over NFS, and compile the Linux kernel  on
the target. Repeat for as long as you like.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Wait!  You have not been prepared!
	-- Mr. Atoz, "Tomorrow is Yesterday", stardate 3113.2

Return-Path: <ndroogh@rogers.com>
Received: from web88105.mail.re2.yahoo.com (web88105.mail.re2.yahoo.com
	[206.190.37.206]) by ozlabs.org (Postfix) with SMTP id D7652DDDED
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 08:04:29 +1100 (EST)
Date: Fri, 7 Nov 2008 12:57:48 -0800 (PST)
From: Nick <ndroogh@rogers.com>
Subject: MPC5200B and the CAN interface
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <390471.16163.qm@web88105.mail.re2.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Everyone,

I am looking for information on how to use the CAN driver for the MPC5200b.  I have built the kernel (2.6.27) with the MPC5200b can bus drivers and I see them being initialized on start up.

[   37.122041] can: controller area network core (rev 20071116 abi 8)
[   37.128687] NET: Registered protocol family 29
[   37.133379] can: raw protocol (rev 20071116)
[   37.137807] can: broadcast manager protocol (rev 20080415)

Do I have to define a UDEV rule?  Has anyone already written a rule to make the can driver visible in /dev?

Any pointers or snippets of code would be greatly appreciated.

Nick

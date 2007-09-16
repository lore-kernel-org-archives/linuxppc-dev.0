Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 9028EDDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 03:05:33 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1803790wag
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Sep 2007 10:05:33 -0700 (PDT)
Message-ID: <9e4733910709161005u4f400ab7wb1bf55dac1b45193@mail.gmail.com>
Date: Sun, 16 Sep 2007 13:05:32 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: Domen's MPC5200 FEC cleanup patch.
In-Reply-To: <9e4733910709161000i64622520i77caa00e56abc7a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
	<9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
	<20070915122218.GB19857@nd47.coderock.org>
	<9e4733910709150855k6ba6dc8fye9762817566208b4@mail.gmail.com>
	<9e4733910709161000i64622520i77caa00e56abc7a8@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[    1.309662] net eth0: attached phy 0 to driver Generic PHY
[    2.316013] Sending DHCP requests .<6>PHY: f0003000:00 - Link is Up
- 100/Full
[    4.392000] ., OK
[    7.100005] IP-Config: Got DHCP answer from 192.168.1.200, my
address is 192.168.1.5
[    7.108154] IP-Config: Complete:
[    7.111247]       device=eth0, addr=192.168.1.5,
mask=255.255.255.0, gw=192.168.1.200,
[    7.119249]      host=MPC, domain=home, nis-domain=(none),
[    7.124811]      bootserver=192.168.1.200, rootserver=192.168.1.4, rootpath=

DHCP wants to print "Sending DHCP requests .., OK"
But the interrupt from the link coming up printed "<6>PHY: f0003000:00
- Link is Up - 100/Full"
The <6> is visible since it wasn't on the beginning of a line.

-- 
Jon Smirl
jonsmirl@gmail.com

Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id E4CF667A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Jun 2006 06:53:59 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Making Two ethernet interfaces up in Linux
Date: Sat, 3 Jun 2006 22:55:05 +0200
References: <c91756f0606030438y62772d89ib43f613cd5373739@mail.gmail.com>
In-Reply-To: <c91756f0606030438y62772d89ib43f613cd5373739@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606032255.05997.antonio.dibacco@aruba.it>
Cc: Shantanu Nalage <shantanu.nalage@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>          We are trying to port Linux on Xilinx Board XUPV2Pro which is
> similar in most aspects to the Xilinx ML300 board. Linux is up and
> running for the original board i.e. having only one ethrnet interface.
> Now since we wanted to have the board working as router, we designed a
> daughter board with two ethernet phy interfaces. The MACs required for
> that are instantiated in Xilinx ....

You have already the driver for the first MAC, then you should start from that 
modifying the init procedure for example and all the others. Your driver 
should initialize both the MACs and also create two devices calling 
init_etherdev tow times. If you post your driver I can suggest what to 
change. It is not so difficult. 

Bye,
Antonio.

Message-ID: <3C67EB09.5010700@embeddededge.com>
Date: Mon, 11 Feb 2002 11:02:17 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: bart@ardistech.com
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: Re: MPC823: i2c-algo-8xx read interrupt?
References: <3C63EC39.ACEECA08@ardistech.com> <3C640532.5000708@embeddededge.com> <3C640C11.4080407@cambridgebroadband.com> <3C6776CC.634AB65D@ardistech.com> <3C67E38C.2020304@embeddededge.com> <3C67E711.2108C6DD@ardistech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


bart@ardistech.com wrote:


> You're right, but spending XX$ on a fast PPC chip and after that let it run
> busy loops to time the I2C control makes me feel bad :)

So, you think interrupt and management overhead of the software to send a
couple of bytes on a 100k serial interface is free?  The chip designers are
often upset when you don't use every feature, but you need to apply some
real systems engineering methods and analyze how all of these little things
help (or hurt) your application.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

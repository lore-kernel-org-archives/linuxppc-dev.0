Message-ID: <3C67EF05.8B20B8A5@ardistech.com>
Date: Mon, 11 Feb 2002 17:19:17 +0100
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: Re: MPC823: i2c-algo-8xx read interrupt?
References: <3C63EC39.ACEECA08@ardistech.com> <3C640532.5000708@embeddededge.com> <3C640C11.4080407@cambridgebroadband.com> <3C6776CC.634AB65D@ardistech.com> <3C67E38C.2020304@embeddededge.com> <3C67E711.2108C6DD@ardistech.com> <3C67EB09.5010700@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
>
> So, you think interrupt and management overhead of the software to send a
> couple of bytes on a 100k serial interface is free?  The chip designers are
> often upset when you don't use every feature, but you need to apply some
> real systems engineering methods and analyze how all of these little things
> help (or hurt) your application.
>
Most important reason for me to do the i2c with the RISC is the scalebility:
if the application needs to do a lot more i2c io as expected it won't affect
the overal performance.

	Bart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

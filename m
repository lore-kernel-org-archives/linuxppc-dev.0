To: Jan Damborsky <jan.damborsky@devcom.cz>
Cc: Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC823E SMC/I2C/SPI micropatch 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Jan 2004 08:23:52 +0100."
             <4014C088.1020208@devcom.cz>
Date: Mon, 26 Jan 2004 09:00:55 +0100
Message-Id: <20040126080100.26782C108D@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <4014C088.1020208@devcom.cz> you wrote:
>
> I have found out that CPM micropatch
> available in linux-2.4 from Wolfgang Denk
> site (the kernel we use successfuly on our
> custom boards at present) is applicable as well.

You have to select the _correct_ uCode patch.

There is one patch for the MPC850, and another one for all other  8xx
processors. And there is the USB SOF potch for the MPC823.


Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Another dream that failed.  There's nothing sadder.
	-- Kirk, "This side of Paradise", stardate 3417.3

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

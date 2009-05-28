Return-Path: <jacmet@gmail.com>
Received: from mail-fx0-f174.google.com (mail-fx0-f174.google.com
	[209.85.220.174]) by ozlabs.org (Postfix) with ESMTP id C1F6DDDF62
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 06:39:38 +1000 (EST)
Received: by fxm22 with SMTP id 22so5792646fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 13:39:36 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk>
	<20090528171726.GE3112@pengutronix.de>
	<d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 28 May 2009 22:34:18 +0200
In-Reply-To: <d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>
	(Esben Haabendal's message of "Thu\,
	28 May 2009 22\:10\:56 +0200")
Message-ID: <87ws8155md.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Esben Haabendal <eha@doredevelopment.dk>, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Esben" == Esben Haabendal <esbenhaabendal@gmail.com> writes:

Hi,

 >> I wanted to test it, but it does not apply due to line breaks (check
 >> @@-line). Also, I don't really have the time to dig into the topic, so I
 >> would only test it and give a tested-by-tag if it doesn't break anything
 >> here. I think Joakim would be a good candidate for an acked-by .

 Esben> I've checked both my copy in my "Sent" folder and the copy
 Esben> received from the list, and I cannot see any "line break"
 Esben> breakage of the patch.

I guess Wolfram referred to the context line which was clearly word wrapped:

@@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap,
struct i2c_msg *msgs, int num)

The other lines look fine.

-- 
Bye, Peter Korsgaard

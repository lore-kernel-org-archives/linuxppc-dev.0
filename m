Return-Path: <jacmet@gmail.com>
Received: from mail-fx0-f174.google.com (mail-fx0-f174.google.com
	[209.85.220.174]) by ozlabs.org (Postfix) with ESMTP id C7B4FDDE21
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 07:08:44 +1000 (EST)
Received: by fxm22 with SMTP id 22so5810581fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 14:08:42 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk>
	<20090528171726.GE3112@pengutronix.de>
	<d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>
	<87ws8155md.fsf@macbook.be.48ers.dk>
	<d2b9ea600905281341s24efa4e3l6277a8aa5dec5bd@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 28 May 2009 23:08:38 +0200
In-Reply-To: <d2b9ea600905281341s24efa4e3l6277a8aa5dec5bd@mail.gmail.com>
	(Esben Haabendal's message of "Thu\,
	28 May 2009 22\:41\:38 +0200")
Message-ID: <87octd5415.fsf@macbook.be.48ers.dk>
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

 Esben> It's strange, that line looks perfectly fine when I check the
 Esben> mail in my GMail inbox and the outbox from the account I sent
 Esben> it from.

Well, it is here and in the archive:
http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072274.html

Please consider using git send-email for patches.

-- 
Bye, Peter Korsgaard

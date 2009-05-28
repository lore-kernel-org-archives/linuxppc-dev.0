Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id 41C0CDDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 07:23:10 +1000 (EST)
Message-ID: <4A1F00AC.3060403@doredevelopment.dk>
Date: Thu, 28 May 2009 23:22:52 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused
	by  read i2c_msg
References: <4A124202.4010201@doredevelopment.dk>	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>	<20090526213351.GG23114@fluff.org.uk>	<20090528171726.GE3112@pengutronix.de>	<d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>	<87ws8155md.fsf@macbook.be.48ers.dk>	<d2b9ea600905281341s24efa4e3l6277a8aa5dec5bd@mail.gmail.com>
	<87octd5415.fsf@macbook.be.48ers.dk>
In-Reply-To: <87octd5415.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
>>>>>> "Esben" == Esben Haabendal <esbenhaabendal@gmail.com> writes:
>>>>>>             
>
> Hi,
>
>  Esben> It's strange, that line looks perfectly fine when I check the
>  Esben> mail in my GMail inbox and the outbox from the account I sent
>  Esben> it from.
>
> Well, it is here and in the archive:
> http://ozlabs.org/pipermail/linuxppc-dev/2009-May/072274.html
>   
If you look at
http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg01050.html
instead, the patch is not broken.  I find it more likely that the ozlabs.org
archive is breaking my lines, than mail-archive.com putting broken lines
together again.
> Please consider using git send-email for patches.
>   
I used git imap-send and thunderbird to do it.

I will consider git send-email in the future, although I don't think
my original e-mail were broken ;-)

But

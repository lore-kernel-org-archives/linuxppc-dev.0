To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm inline
References: <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
	<20021202131158.GA2427@ibrium.se> <jevg2cee7e.fsf@sykes.suse.de>
	<200212020914.21465.kevin.hendricks@sympatico.ca>
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 02 Dec 2002 15:29:47 +0100
In-Reply-To: <200212020914.21465.kevin.hendricks@sympatico.ca> ("Kevin B.
 Hendricks"'s message of "Mon, 2 Dec 2002 09:14:21 -0500")
Message-ID: <jeisycebok.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" <kevin.hendricks@sympatico.ca> writes:

|> Hi,
|>
|> I thought strict-aliasing was only turned on at -O3?
|> It was that way in the past.  Did this change for gcc-3.2.X?

Yes, strict aliasing is now the default.

|> There seems to be an enormous amount of code that is not strict-aliasing
|> safe (in the JDK, in OpenOffice.org, etc).

Well, they have always walked on thin ice...

|> Is there any warning flag that can be enabled to help find these cases (the
|> OOo source base is simply huge)?

gcc 3.3 implements such a warning, but it may give many false positives.

Andreas.

--
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

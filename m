From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bryce McKinlay <bryce@waitaki.otago.ac.nz>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: benh's kernel is unable to compile.
Date: Tue, 30 Oct 2001 10:17:24 +0100
Message-Id: <20011030091724.4260@smtp.adsl.oleane.com>
In-Reply-To: <3BDE0FEB.1050206@waitaki.otago.ac.nz>
References: <3BDE0FEB.1050206@waitaki.otago.ac.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>FYI I built 2.4.14-pre2-ben0 out of rsync about 2 hours ago and it seems
>to be working. It does get some IDE errors about lost IRQs during bootup
>that didn't happen with 2.4.13-ben0. Eventually it said "ide0: reset"
>and now appears to be working normally. This is on a Powebook G4.

That's absolutely not normal. Can you send me a dmesg log of this
situation ? The ide:reset will have disabled DMA, thus causing your
to be very slow.

If you re-enable DMA later one (hdparm -d1 /dev/hda), to you again
get lost IRQs & ide reset or does it stick ?


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

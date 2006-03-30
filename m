Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0603301351qba22edn70e2f4052034bb78@mail.gmail.com>
Date: Thu, 30 Mar 2006 14:51:26 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: Kernel for MPC Lite 5200 will not compile
In-Reply-To: <20060330200509.10908.qmail@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <442B11E8.7020107@246tNt.com>
	<20060330003419.3FF71353A37@atlas.denx.de>
	<4b73d43f0603300829q7d45a029qdb5d8006ccda7275@mail.gmail.com>
	<4b73d43f0603300839k4465b2aao7e073f83052b97ff@mail.gmail.com>
	<20060330200509.10908.qmail@farnsworth.org>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Even if the current Freescale code were cleaned up the basic design is
ugly.  The C preprocessor hell it goes through along with the
indirection is a high price to pay for the generalitiy it buys in
terms of the task var/inc setting.

On the licensing side, it has been changed to an MIT license so it can
be included in the kernel but third parties can use it in there non
GPL OSs without problem.

For now lets just stay with your code and I will work on getting other
drivers to use it.

On 30 Mar 2006 20:05:09 -0000, Dale Farnsworth <dale@farnsworth.org> wrote:
> Jon Rigby <jcrigby@gmail.com> wrote:
> > After thinking about this more....I don't want to push getting the offi=
cial
> > Freescale code into the tree.  If Dale's code works as well as the Free=
scale
> > code then lets stay with it because it is a lot cleaner.
>
> Thanks.
>
> > The effort of porting other drivers will hopefully be easier now that
> > I have the experience of having done ATA.
>
> Would Freescale be amenable to working toward a revised, common, API?
> Unfortunately, I didn't find the Freescale Bestcomm API to be clean enoug=
h
> for acceptance into Linux, so changes would be needed.
>
> -Dale
>

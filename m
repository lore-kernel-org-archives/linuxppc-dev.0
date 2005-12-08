Return-Path: <dalang@cs.ubc.ca>
Received: from mail-relay1.cs.ubc.ca (mail-relay1.cs.ubc.ca [142.103.6.79])
	by ozlabs.org (Postfix) with ESMTP id DDFFF688C5
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2005 02:10:14 +1100 (EST)
Date: Thu, 8 Dec 2005 07:10:04 -0800 (PST)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1134038881.11760.11.camel@gaston>
Message-ID: <Pine.LNX.4.60.0512080706390.29467@tin.icics.ubc.ca>
References: <20051026215535.GA5713@campbell-lange.net>
	<1133124018.7768.107.camel@gaston>
	<87veydaftb.fsf@oedipa.disorg> <1133130209.7768.136.camel@gaston>
	<877jatemic.fsf@oedipa.disorg> <1133132287.7768.138.camel@gaston>
	<87oe45d0j4.fsf@oedipa.disorg> <1133142131.7768.156.camel@gaston>
	<87ek51cycq.fsf@oedipa.disorg> <1133145863.7768.165.camel@gaston>
	<73eb1cf90511271913k1786facev55038e567c51d19c@mail.gmail.com>
	<1133150158.7768.177.camel@gaston> <87zmnpbe34.fsf@oedipa.disorg>
	<1133151191.7768.183.camel@gaston> <87hd9wak4a.fsf@oedipa.disorg>
	<1133210294.7768.190.camel@gaston>  <87bqzs5cio.fsf@oedipa.disorg>
	<1134038881.11760.11.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Guy Yasko <gyasko@gmail.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Fix boot on some 12" powerbooks, need testers on others
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It boots on my PowerBook6,2 (12" Oct'03).

Cheers,
dstn.

On Thu, 8 Dec 2005, Benjamin Herrenschmidt wrote:
> This patch against 2.6.15-rc5 might help fixing boot on some recent
> powerbooks like some 12" aluminium. However, I need urgently some
> testers with other models of powerbooks and mac mini to tell me if it
> causes any regression (that is before tomorrow) so it _might_ have a
> chance to make it in 2.6.15.

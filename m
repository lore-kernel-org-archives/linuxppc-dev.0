Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DF90EB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 13:16:46 +1100 (EST)
Date: Tue, 5 Oct 2010 22:10:04 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 05/18] powerpc: Wire up 44x little endian boot for
	remaining 44x targets
Message-ID: <20101005221004.5dc6e1b6@lappy.seanm.ca>
In-Reply-To: <AANLkTimNeWEo5P0wXzszBiSYdh81=uhARA8KZPr7rcPf@mail.gmail.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-6-git-send-email-imunsie@au1.ibm.com>
	<AANLkTins34TrEWj618_4XBRwGGFqRSehwWEp7jBubvsu@mail.gmail.com>
	<1286327715-sup-584@au1.ibm.com>
	<AANLkTimNeWEo5P0wXzszBiSYdh81=uhARA8KZPr7rcPf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, paulus <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Oct 2010 21:55:35 -0400
Josh Boyer <jwboyer@gmail.com> wrote:

> Well, Warp and Sam440EP are production boards for actual companies.
> The rest are all just eval boards.  I don't know if the board
> maintainers care either way, I was just using them as examples of
> cases where someone might.

In the warp case, I basically don't care. I know LE would break some of
our telephony drivers since we assume PPC is BE. But on the other hand,
realistically, it will never get turned on by customers anyway.

We have to provide our own .config anyway, so it really don't hurt us
as long as it doesn't break BE support.

Cheers,
   Sean

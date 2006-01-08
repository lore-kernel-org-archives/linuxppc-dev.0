Return-Path: <schwab@suse.de>
From: Andreas Schwab <schwab@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1136695956.30123.44.camel@localhost.localdomain>
	<jefynz0zvr.fsf@sykes.suse.de>
Date: Sun, 08 Jan 2006 14:30:36 +0100
In-Reply-To: <jefynz0zvr.fsf@sykes.suse.de> (Andreas Schwab's message of "Sun,
	08 Jan 2006 11:37:12 +0100")
Message-ID: <jewtha3kzn.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Fix PowerMac sound i2c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@suse.de> writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
>> My patch reworking the PowerMac i2c code break the sound drivers as they
>> used to rely on some broken behaviour of i2c-keywest that is gone now.
>
> I'm not sure, but from looking at the other i2c drivers I'd rather think
> that the old behaviour of i2c-keywest was correct.

I have now read the thread on linux-kernel@ and I have to revise my
opinion.  I think I now understand better the difference between smbus and
i2c bus.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

Return-Path: <schwab@suse.de>
From: Andreas Schwab <schwab@suse.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Floating point exceptions with MPC5200
References: <497448F4.7080806@grandegger.com>
Date: Mon, 19 Jan 2009 10:50:20 +0100
In-Reply-To: <497448F4.7080806@grandegger.com> (Wolfgang Grandegger's message
	of "Mon, 19 Jan 2009 10:33:40 +0100")
Message-ID: <je7i4rk4kj.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger <wg@grandegger.com> writes:

> I want to provoke a "floating point exception" by doing a division by 0.

Division by 0 is undefined, so you cannot expect any kind of outcome.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

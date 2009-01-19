Return-Path: <wg@grandegger.com>
Message-ID: <49744EA9.6060402@grandegger.com>
Date: Mon, 19 Jan 2009 10:58:01 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Subject: Re: Floating point exceptions with MPC5200
References: <497448F4.7080806@grandegger.com> <je7i4rk4kj.fsf@sykes.suse.de>
In-Reply-To: <je7i4rk4kj.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Wolfgang Grandegger <wg@grandegger.com> writes:
> 
>> I want to provoke a "floating point exception" by doing a division by 0.
> 
> Division by 0 is undefined, so you cannot expect any kind of outcome.

Hm, even not a "floating point exception" signal like on x86?

Wolfgang.

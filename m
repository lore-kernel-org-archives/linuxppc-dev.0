Return-Path: <wg@grandegger.com>
Message-ID: <497448F4.7080806@grandegger.com>
Date: Mon, 19 Jan 2009 10:33:40 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Floating point exceptions with MPC5200
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I want to provoke a "floating point exception" by doing a division by 0.
The expection does come as expected on my x86 PC:

  $ ./divby0
  Floating point exception

but not on my MPC5200 board. Any idea why? I think the processor can
handle all floating-point exceptions. I'm using Linux 2.6.28 and the
ELDK v4.2.

Wolfgang.

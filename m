Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17666.7265.178581.550386@cargo.ozlabs.ibm.com>
Date: Sat, 9 Sep 2006 11:44:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: "John Rigby" <jcrigby@gmail.com>
Subject: Re: powerpc power management
In-Reply-To: <4b73d43f0609080718g743b9e6bje7202e5293c0abaa@mail.gmail.com>
References: <4b73d43f0609071905j26ab0317k144d78963e041cba@mail.gmail.com>
	<450121E2.5050207@in.ibm.com>
	<4b73d43f0609080718g743b9e6bje7202e5293c0abaa@mail.gmail.com>
Cc: linuxppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rigby writes:

> MPC5200 which has a 603 core.

What support does the rest of the system provide for suspend/resume?
Generally the issue is not with getting the processor into sleep mode,
it's how you poke the rest of the system to put the RAM into
self-refresh mode, power down external buses, etc.  That stuff tends
to be very platform-specific.

Paul.

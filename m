Return-Path: <groove.c@gmail.com>
Message-ID: <ac3922a00609140500j79e33fb3lfecbefc151ce3b41@mail.gmail.com>
Date: Thu, 14 Sep 2006 14:00:21 +0200
From: "Syed Amer Gilani" <amg@systec.de>
Sender: groove.c@gmail.com
To: Linuxppc-embedded@ozlabs.org
Subject: Measure Interrupt Latency on MPC5200B
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We have a MPC5200B(ppc) Board from Phytec, running with a 2.6 Linux
Kernel. For Documentation purposes and testings how patches to the
Kernel affects real time capabilities we want to measure the Interrupt
Latency.
I only found tools for other arches or patches for far to old kernels.
Does somebody know a way for a 2.6 kernel on ppc? I already thought of
generating a signal on an Output of the Board and measure it with a
Oscilloscope but i don't find that method satisfying.

Thank you in advance,
Syed Amer Gilani
